{ config, pkgs, ... }:
{
  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;
  };
  services.displayManager.cosmic-greeter.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
}
