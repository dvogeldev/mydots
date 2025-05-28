{ lib, ... }:
{
  options.my.desktop = lib.mkOption {
    type = lib.types.enum [ "sway" "gnome" "cosmic" "none" ];
    default = "none";
    description = "The desktop environment to use.";
  };
}
