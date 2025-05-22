# This is modules/impermanence.nix

{ config, lib, pkgs, ... }:

let
  # The impermanence module fetch (moved here for modularity)
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz"; # From your configuration [cite: 1]
in
{
  imports = [
    # Import the impermanence module itself
    "${impermanence}/nixos.nix" # From your configuration [cite: 3]
  ];

  # Impermanence configuration (root filesystem)
  # The actual rootfs will be `@root`, which is ephemeral
  fileSystems."/" = {
    device = "/dev/mapper/cryptroot"; # From your configuration [cite: 8]
    fsType = "btrfs"; # From your configuration [cite: 8]
    options = [ "subvol=@root" "compress=zstd:3" "noatime" ]; # From your configuration [cite: 8]
  };

  # Paths from the root that need to persist across reboots.
  # These will be automatically bind-mounted from /persist.
  # This is crucial for making the root ephemeral but keeping necessary state.
  environment.persistence."/persist" = { # From your configuration [cite: 11]
    hideMounts = true; # From your configuration [cite: 12]
    # Hides the underlying btrfs mounts from the ephemeral root
    directories = [ # From your configuration [cite: 12]
      "/etc/nixos"      # Your NixOS configuration files
      "/etc/ssh"        # SSH host keys
      "/var/lib"        # Databases, Docker volumes, general application data
      "/var/cache"      # Persistent caches (e.g., for package managers)
      "/var/empty"      # Required by some services like sshd [cite: 13]
      "/var/log"        # Logs should typically persist
      "/var/tmp"        # Persistent temporary files for things like builds
      "/var/lib/docker" # From your configuration [cite: 13]
      # "/opt"            # For manually installed software if you use it [cite: 13]
      # "/srv"            # For server data [cite: 13]
    ];
    files = [ # From your configuration [cite: 14]
      "/etc/machine-id" # From your configuration [cite: 14]
      # TODO Add specific files you want to persist [cite: 14]
    ];
  };

  # Use tmpfs for /tmp for performance and impermanence
  fileSystems."/tmp" = {
    device = "tmpfs"; # From your configuration [cite: 16]
    fsType = "tmpfs"; # From your configuration [cite: 16]
    options = [ "mode=1777" ]; # From your configuration [cite: 16]
  };
}
