# This is your main configuration.nix file
# (located at nixos/configuration.nix in the starter config structure)

{ config, lib, pkgs, ... }:

{
  imports = [
    # Import your hardware configuration
    ./hardware-configuration.nix

    # Core system settings, network, locale, etc.
    ../modules/nixos
  ];

  # Nix package manager settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Already in your config and standard template

  # This option defines the first version of NixOS you have installed on this particular machine.
  # DO NOT change this value after the initial install unless you understand the implications.
  # It does NOT affect the Nixpkgs version your packages and OS are pulled from.
  system.stateVersion = "25.05"; # Retain your specified state version [cite: 39]
}
