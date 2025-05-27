{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  
  # Nvidia
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  boot.kernelParams = [ "nouveau.modeset=0" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  environment.systemPackages = with pkgs; [
    libva-utils
    vdpauinfo
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_RENDER_DRM_FENCE = "1";
   #  WLR_NO_HARDWARE_CURSORS = "1";
   #  __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # Force GLX to use NVIDIA
  };
}
