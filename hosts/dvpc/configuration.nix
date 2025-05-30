# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  themeConfig,
  ...
}: {

  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example
    outputs.nixosModules.desktop-option

    # Or modules from other flakes (such as nixos-hardware):
    # TODO inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ../common
    ../options/data-drive.nix
    ../options/firewall.nix
    ../options/nvidia.nix
    ../desktop/sway.nix
    ../desktop/gnome.nix
    ../desktop/hyprland.nix
    ../desktop/cosmic.nix

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

  # Set the desktop environment
  my.desktop = "hyprland"; # Change to "gnome" or "cosmic" or "none" as needed

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
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0;
      trusted-users = [ "root" "david" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Dbus
  services.dbus.enable = true;

  # Auto Scrub & Trim
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/" ];
    interval = "weekly";
  };
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # Flatpaks
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # services.libinput.enable = true;

  users.users = {
    david = {
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      isNormalUser = true;
      initialHashedPassword = "$6$.eWVdDJVVk8wNrM3$zW.r0Jy.p8D3iBLN9GbIP9czEF2iXkIOcy.t/qjSHMSImVrM37k.d6jHAcM1BIeFxkc2Lg5bltNDFB/VBHpba/";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = ["wheel" "networkmanager" "libvirtd" "podman"];
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
    alejandra
    gnutar
    xz
    zip
    unzip
  ];

  stylix = {
    enable = true;
    image = themeConfig.wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${themeConfig.base16}.yaml";
    polarity = themeConfig.polarity;

    fonts = {
      serif = {
        package = pkgs.liberation_ttf;
	name = "Liberation";
      };
      sansSerif = {
        package = pkgs.poppins;
	name = "Poppins";
      };
      monospace = {
        package = pkgs.nerd-fonts.hasklug;
	name = "Hasklug Nerd Fonts";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
	name = "Noto Color Emoji";
      };
      sizes.applications = 14;
      sizes.popups = 14;
      sizes.desktop = 14;
    };
  };

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

  security = {
    sudo.enable = true;
    rtkit.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
