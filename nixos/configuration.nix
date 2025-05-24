# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./data-drive.nix
    ./keyd.nix
    ./podman.nix
    ./firewall.nix
    ./nvidia.nix

    #  "${impermanence}/nixos.nix"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;

  # Enable ZRAM (LZ4, 50% of RAM)
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 50;
  };

  # Impermanence configuration (root filesystem)
  # The actual rootfs will be `@root`, which is ephemeral
  fileSystems."/" = {
    device = "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = ["subvol=@root" "compress=zstd:3" "noatime"];
  };

  # Paths from the root that need to persist across reboots.
  # These will be automatically bind-mounted from /persist.
  # This is crucial for making the root ephemeral but keeping necessary state.
  # environment.persistence."/persist" = {
  #   hideMounts = true; # Hides the underlying btrfs mounts from the ephemeral root
  #   directories = [
  #     "/etc/nixos"      # Your NixOS configuration files
  #     "/etc/ssh"        # SSH host keys
  #     "/var/lib"        # Databases, Docker volumes, general application data
  #     "/var/cache"      # Persistent caches (e.g., for package managers)
  #     "/var/empty"      # Required by some services like sshd
  #     # Add any other directories from the root that MUST persist, e.g.:
  #     # "/var/lib/postgresql"
  #     "/var/lib/docker"
  #     # "/opt"            # For manually installed software if you use it
  #     # "/srv"            # For server data
  #   ];
  #   files = [
  #     # TODO Add specific files you want to persist, e.g.:
  #     "/etc/machine-id"
  #   ];
  # };

  # Use tmpfs for /tmp for performance and impermanence
  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = ["mode=1777"];
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
      download-buffer-size = 16 * 1024 * 1024; #fix for download buffer size warning
    };

    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  networking.hostName = "dvpc";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Detroit";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    xkb.layout = "us";
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Dbus
  services.dbus.enable = true;

  # services.libinput.enable = true;

  users.users = {
    david = {
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      isNormalUser = true;
      initialHashedPassword = "$6$.eWVdDJVVk8wNrM3$zW.r0Jy.p8D3iBLN9GbIP9czEF2iXkIOcy.t/qjSHMSImVrM37k.d6jHAcM1BIeFxkc2Lg5bltNDFB/VBHpba/";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = ["wheel" "networkmanager" "libvirtd"];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    brave
    wget
    git
    distrobox
    sops
    procs
    fish
    age
    fontconfig
    liberation_ttf
    poppins
    nerd-fonts.hasklug
    nerd-fonts.intone-mono
    alejandra
  ];

  programs.command-not-found.enable = true;
  programs.dconf.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  security.sudo.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
