{ config, pkgs, ... }:
{
  imports = [
    ./keyd.nix
    ./podman.nix
    ./fonts.nix
    ./sound.nix
  ];
}
