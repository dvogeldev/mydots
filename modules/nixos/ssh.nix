# This is modules/ssh.nix

{ config, lib, pkgs, ... }:

{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true; # From your configuration [cite: 29]
}
