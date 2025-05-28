# home-manager/desktop/sway.nix
{ config, pkgs, ... }:
let
  mod = "Mod4"; # Super key
in
{
  # Systemd user service to start sway on tty1
  systemd.user.services.sway-autostart = {
    Unit = {
      Description = "Auto start sway on tty1";
      After = [ "graphical-session-pre.target" ];
    };
    Service = {
      ExecStart = "${pkgs.sway}/bin/sway";
      Restart = "on-failure";
      Environment = "XDG_SESSION_TYPE=wayland";
      TTYPath = "/dev/tty1";
      StandardInput = "tty";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      output = {
        "DP-1" = {
          mode = "3840x2160@60Hz";
	  position = "0 0";
	  scale = 1.6;
	};
        "DP-2" = {
          mode = "3840x2160@60Hz";
	  position = "3840 0";
	  scale = 1.6;
	};
      };
      workspaceOutputAssign = {
        "1" = "DP-1";
        "2" = "DP-1";
        "3" = "DP-1";
        "4" = "DP-1";
        "5" = "DP-2";
        "6" = "DP-2";
        "7" = "DP-2";
        "8" = "DP-2";
      };
      assigns = [
        { workspace = "1"; app_id = "ghostty"; }
        { workspace = "2"; app_id = "emacs"; }
        { workspace = "5"; app_id = "brave"; }
      ];
      modifier = mod;
      terminal = "ghostty";
      menu = "fuzzel";
      bars = [{
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
      }];
      keybindings = {
        "${mod}+Return" = "exec ghostty -e fish";
        "${mod}+d" = "exec fuzzel";
        "${mod}+e" = "exec emacsclient -c -a 'emacs'";
        "${mod}+q" = "kill";
        # ...add more as needed
      };
      # Add more config as needed (workspaces, gaps, etc.)
    };
  };

  # i3status-rust config (minimal example)
  programs.i3status-rust = {
    enable = true;
    bars.default = {
      theme = "gruvbox-dark";
      blocks = [
        { block = "cpu"; }
        { block = "memory"; }
        { block = "time"; }
      ];
    };
  };

  # User packages
  home.packages = with pkgs; [
    ghostty
    fuzzel
    i3status-rust
    wl-clipboard
    grim
    slurp
    mako
    kanshi
  ];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
  };
}
