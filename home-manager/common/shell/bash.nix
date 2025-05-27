_: {
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      set -o vi
    '';
    initExtra = "";
  };
}
