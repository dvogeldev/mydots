# nixos/desktop/sway.nix
{ config, pkgs, lib, ... }:
{

  config = lib.mkIf (config.my.desktop == "sway") {

    hardware.nvidia-container-toolkit = {
      suppressNvidiaDriverAssertion = true;
      enable = false;
    };

    # Disable default lightdm
    services.xserver.displayManager.lightdm.enable = false;

    # Enable Sway and required system packages
    programs.sway.enable = true;

    environment.systemPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      grim
      slurp
      mako
      kanshi
      # Ghostty is managed in home-manager, but can be added here if you want system-wide
    ];

    # XDG portal for Wayland
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
