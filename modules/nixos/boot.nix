# This is modules/boot.nix

{ config, lib, pkgs, ... }:

{
  # Use the GRUB 2 boot loader.
  # This section is tailored to your preference for systemd-boot.
  boot.loader.systemd-boot.enable = true; # From your configuration [cite: 4]
  boot.loader.efi.canTouchEfiVariables = true; # From your configuration [cite: 4]
  boot.loader.timeout = 3; # From your configuration [cite: 4]
  # boot.loader.grub.efiInstallAsRemovable = true; # Commented in your config [cite: 4]
  # boot.loader.efi.efiSysMountPoint = "/boot/efi"; # Commented in your config [cite: 4]
  # boot.loader.grub.device = "/dev/sda"; # Commented in your config [cite: 5]
  # or "nodev" for efi only # Commented in your config [cite: 6]
}
