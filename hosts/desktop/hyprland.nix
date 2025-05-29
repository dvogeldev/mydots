{ config, pkgs, lib, ... }:
{

  config = lib.mkIf ( config.my.desktop == "hyprland") {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    hardware.graphics.enable = true;  # Opengl

    # TODO investigate whether the override is necessary
    environment.systemPackages = with pkgs; [
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
	})
       )
       dunst
       libnotify
       swww
       fuzzel
    ];
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };
}
