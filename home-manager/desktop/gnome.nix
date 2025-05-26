{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-panel

    gnome-extension-manager
    gnome-tweaks

    papirus-icon-theme
    bibata-cursors
  ];

  dconf.settings = {
    # Enable extensions
    "org/gnome/shell" = {
      enabled-extensions = [
        "blur-my-shell@aunetx"
	"dash-to-panel@jderose9.github.com"
      ];
      disable-user-extensions = false;
    };

  # Gnome keyboard shortcuts
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "ghostty -e fish";
      name = "Terminal";
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>b";
      command = "brave";
      name = "Brave browser";
    };

    # Icon and cursor theme
    "org/gnome/desktop/interface" = {
      cursor-theme = "Bibata-Modern-Ice";
      icon-theme = "Papirus";
    };

    # Blur My Shell
    "org/gnome/shell/extensions/blur-my-shell" = {
      blur-applications = true;
      blur-overview = true;
      blur-panel = true;
      blur-dash = true;
      brightness = 0.6;
      sigma = 30;
    };

    # Dash to Panel
    "org/gnome/shell/extensions/dash-to-prompt" = {
      panel-position = "BOTTOM";
      panel-size = 40;
      appicon-margin = 4;
      appicon-padding = 4;
      show-favorites = true;
      show-running-apps = true;
      show-window-previews = true;
    };
  };
}
