{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./aliases.nix
    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./bottom.nix
    ./eza.nix
    ./fish.nix
    ./fzf.nix
    ./lazygit.nix
    ./ripgrep.nix
    ./skim.nix
    ./tealdeer.nix
    ./yazi.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [fastfetch just glances killall];
}
