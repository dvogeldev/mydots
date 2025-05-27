# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  themeConfig,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./common
    ./apps
    ./editor
    ./desktop/gnome.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "david";
    homeDirectory = "/home/david";
    packages = with pkgs; [
      coreutils
      freetube
      gcc
      jq
      adwaita-icon-theme
      brave
      easyeffects
      wl-clipboard
      wlr-randr
      zip
    ];
    # sessionVariables = {
    #   XCURSOR_THEME = "adwaita";
    #   XCURSOR_SIZE = "24";
    # };
  };

  # gtk = {
  #   enable = true;
  #   cursorTheme = {
  #     name = "Adwaita";
  #     size = 24;
  #   };
  # };

  stylix = {
    enable = true;
    autoEnable = true;
    image = themeConfig.wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${themeConfig.base16}.yaml";
    polarity = themeConfig.polarity;

    fonts = {
      serif = {
        package = pkgs.liberation_ttf;
	name = "Liberation";
      };
      sansSerif = {
        package = pkgs.poppins;
	name = "Poppins";
      };
      monospace = {
        package = pkgs.nerd-fonts.hasklug;
	name = "Hasklug Nerd Fonts";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
	name = "Noto Color Emoji";
      };
      sizes.applications = 14;
      sizes.popups = 14;
      sizes.desktop = 14;
    };
    # cursor.size = 48;
  };


  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.fd.enable = true;
  # programs.starship.enable = true;

  # Services
  services.easyeffects.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";

  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 7d";
  };
}
