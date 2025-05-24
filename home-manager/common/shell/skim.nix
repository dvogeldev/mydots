{
  pkgs,
  config,
  ...
}: {
  programs.skim = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f";
  };
}
