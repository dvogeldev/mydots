{
  config,
  pkgs,
  ...
}: {
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {style = "compact";};
  };
}
