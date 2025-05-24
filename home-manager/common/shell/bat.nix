{
  config,
  pkgs,
  ...
}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
    };
    themes = {
      kanagawa = {
        src = pkgs.fetchFromGitHub {
          owner = "rebelot";
          repo = "kanagawa.nvim";
          rev = "debe91547d7fb1eef34ce26a5106f277fbfdd109";
          sha256 = "i54hTf4AEFTiJb+j5llC5+Xvepj43DiNJSq0vPZCIAg="; # This will fail and Nix will suggest the correct hash
        };
        file = "extras/tmTheme/kanagawa.tmTheme";
      };
    };
  };
}
