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
  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-panel
    gnome-extension-manager
    gnome-tweaks
    papirus-icon-theme
    bibata-cursors
  ];
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  # Optionally, set GTK icon/cursor theme for display managers and apps
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=Papirus
    gtk-cursor-theme-name=Bibata-Modern-Ice
  '';
  environment.etc."xdg/gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=Papirus
    gtk-cursor-theme-name=Bibata-Modern-Ice
  '';
}
