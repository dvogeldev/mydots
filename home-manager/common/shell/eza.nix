{
  config,
  pkgs,
  ...
}: {
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    extraOptions = ["-l" "--git" "--header" "-a" "--group-directories-first"];
    icons = "auto";
  };
}
