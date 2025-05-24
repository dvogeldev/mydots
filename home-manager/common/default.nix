{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./shell
    ./fonts.nix
  ];
}
