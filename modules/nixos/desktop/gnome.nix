# This is modules/desktop/gnome.nix

{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = { # From your configuration [cite: 18]
    enable = true; # From your configuration [cite: 18]
    xkb.layout = "us"; # From your configuration [cite: 18]
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true; # From your configuration [cite: 19]
  services.xserver.desktopManager.gnome.enable = true; # From your configuration [cite: 19]

  # Optional: Enable CUPS to print documents.
  # services.printing.enable = true; # From your configuration [cite: 19]
}
