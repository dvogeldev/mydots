# This is nixos/modules/nixos/zram.nix

{ config, lib, pkgs, ... }:

{
  # Enable ZRAM (LZ4, 50% of RAM)
  zramSwap = { # From your configuration [cite: 6]
    enable = true;
    algorithm = "lz4"; # From your configuration [cite: 7]
    memoryPercent = 50; # From your configuration [cite: 7]
  };
}
