{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ fontconfig ];

  fonts.packages = with pkgs; [
    liberation_ttf
    nerd-fonts.hasklug
    nerd-fonts.intone-mono
    maple-mono.NF-unhinted # Maple Mono font https://font.subf.dev/en/download/
    poppins
  ];
}
