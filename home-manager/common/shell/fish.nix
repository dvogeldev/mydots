{
  config,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
    shellInit = ''
      set -u fish_greeting ""
      fish_vi_key_bindings

      # environment variables
      set -gx TERMINAL "ghostty"
      # set -gx EDITOR "emacsclient -c -a 'Emacs'"
      set -gx manpager "sh -c 'col -bx | bat -l man -p'"
    '';
    plugins = [
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf.src;
      }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
  };
}
