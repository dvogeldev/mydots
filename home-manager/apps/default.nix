{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./freetube.nix
    #./ghostty.nix
    ./ptyxis.nix
  ];
}
