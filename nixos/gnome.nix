{ config, pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    xkb.layout = "us";
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;
  };
}
