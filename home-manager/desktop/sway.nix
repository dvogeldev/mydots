# home-manager/desktop/sway.nix
{ config, pkgs, ... }:
let
  mod = "Mod4"; # Super key
in
{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = mod;
      terminal = "ghostty";
      menu = "fuzzel";
      bars = [{
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
      }];
      keybindings = {
        "${mod}+Return" = "exec ghostty";
        "${mod}+d" = "exec fuzzel";
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
}
