# This is modules/core.nix

{ config, lib, pkgs, ... }:

{
  # Networking
  networking.hostName = "dvpc"; # From your configuration [cite: 17]
  networking.networkmanager.enable = true; # From your configuration [cite: 17]

  # Firewall: Enabled by default as a good standard practice
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ]; # Add specific ports if needed [cite: 30]
  # networking.firewall.allowedUDPPorts = [ ... ]; # Add specific ports if needed [cite: 30]

  # Time and locale
  time.timeZone = "America/Detroit"; # From your configuration [cite: 17]
  i18n.defaultLocale = "en_US.UTF-8"; # From your configuration [cite: 17]

  # Sound
  services.pipewire = {
    enable = true; # From your configuration [cite: 20]
    pulse.enable = true; # From your configuration [cite: 20]
  };

  # Input
  services.libinput.enable = true; # From your configuration [cite: 21]

  # Program-specific configurations
  programs.command-not-found.enable = true; # From your configuration [cite: 22]
  programs.gnupg.agent = { # From your configuration [cite: 28]
    enable = true;
    enableSSHSupport = true;
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [ # From your configuration [cite: 25]
    neovim # From your configuration [cite: 25]
    brave # From your configuration [cite: 26]
    wget # From your configuration [cite: 26]
    git # From your configuration [cite: 26]
  ];

  # Copy the NixOS configuration file to the resulting system
  # This is useful in case you accidentally delete configuration.nix.
  system.copySystemConfiguration = true; # Was commented out in yours, but good standard practice [cite: 33]
}
