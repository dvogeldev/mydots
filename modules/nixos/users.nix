# This is modules/users.nix

{ config, lib, pkgs, ... }:

{
  users.users.david = { # From your configuration [cite: 21]
    isNormalUser = true; # From your configuration [cite: 21]
    initialHashedPassword = "$6$.eWVdDJVVk8wNrM3$zW.r0Jy.p8D3iBLN9GbIP9czEF2iXkIOcy.t/qjSHMSImVrM37k.d6jHAcM1BIrFxc2Lg5bltNDFB/VBHpba/"; # From your configuration [cite: 21]
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ]; # From your configuration [cite: 21]
    packages = with pkgs; [ # From your configuration [cite: 22]
      tree # From your configuration [cite: 22]
    ];
  };
}
