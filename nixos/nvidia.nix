{
  config,
  pkgs,
  ...
}: {
  # Nvidia
  hardware.nvidia = {
    modesetting.enable = true;
    forceFullCompositionPipeline = true;
    powerManagement.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # Force GLX to use NVIDIA
  };
}
