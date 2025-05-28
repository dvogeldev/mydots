{ config, pkgs, lib, ... }:
{
  config = lib.mkIf (config.my.desktop == "cosmic") {
    services.desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true;
    };
    services.displayManager.cosmic-greeter.enable = true;
    environment.systemPackages = with pkgs; [
      nerd-fonts.hasklug
      nerd-fonts.intone-mono
    ];
  };
}
