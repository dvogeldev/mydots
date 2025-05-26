{ config, pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

  # Force Wayland backend
  home.sessionVariables = {
    GDK_BACKEND = "wayland";
    PATH = "XDG_CONFIG_HOME/emacs/bin:$PATH";
  };

  home.packages = with pkgs; [
    binutils # native-comp needs 'as' provided by this
    gnutls
    emacsPackages.vterm
    fd
    imagemagick
    libvterm
    nixfmt-rfc-style
    nixd
    pinentry-emacs
    zstd

    editorconfig-core-c
    sqlite
    clang-tools
    age

    aspell
    aspellDicts.en
  ];

}
