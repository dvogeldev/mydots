{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # NVIDIA proprietary drivers for GNOME
    (lib.mkIf (config.my.desktop == "gnome" || config.my.desktop == "hyprland") {
      services.xserver.enable = true;
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        open = true;
        nvidiaSettings = true;
      };
      boot.kernelParams = [ "nouveau.modeset=0" ];
      boot.blacklistedKernelModules = [ "nouveau" ];
      environment.systemPackages = with pkgs; [ libva-utils vdpauinfo ];
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        WLR_RENDER_DRM_FENCE = "1";
      };
    })

    # Nouveau for Sway
    (lib.mkIf (config.my.desktop == "sway") {
      services.xserver.enable = true;
      services.xserver.videoDrivers = [ "nouveau" ];
      boot.kernelParams = lib.mkForce [];
      boot.blacklistedKernelModules = lib.mkForce [];
      environment.systemPackages = with pkgs; [ mesa ];
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
    })
  ];
}
