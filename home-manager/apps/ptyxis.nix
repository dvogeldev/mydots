{
  config,
  pkgs,
  ...
}: {
  programs.ptyxis = {
    enable = true;
    palettes = {
      kanagawa-dragon = {
        Pallet.Name = "Kanagawa Dragon";
        Dark = {
          cursor-color = "#c8c093";
          background = "#181616";
          foreground = "#c5c9c5";
          selection-background = "#2d4f67";
          selection-foreground = "#c8c093";
          Color0 = "#0d0c0c";
          Color1 = "#c4746e";
          Color2 = "#8a9a7b";
          Color3 = "#c4b28a";
          Color4 = "#8ba4b0";
          Color5 = "#a292a3";
          Color6 = "#8ea4a2";
          Color7 = "#c8c093";
          Color8 = "#a6a69c";
          Color9 = "#e46876";
          Color10 = "#87a987";
          Color11 = "#e6c384";
          Color12 = "#7fb4ca";
          Color13 = "#938aa9";
          Color14 = "#7aa89f";
          Color15 = "#c5c9c5";
        };
      };
      kanagawa-wave = {
        Palet.Name = "Kanagawa Wave";
        Light = {
          background = "#1f1f28";
          foreground = "#dcd7ba";
          cursor-color = "#c8c093";
          selection-background = "#2d4f67";
          selection-foreground = "#c8c093";
          Color0 = "#16161d";
          Color1 = "#c34043";
          Color2 = "#76946a";
          Color3 = "#c0a36e";
          Color4 = "#7e9cd8";
          Color5 = "#957fb8";
          Color6 = "#6a9589";
          Color7 = "#c8c093";
          Color8 = "#727169";
          Color9 = "#e82424";
          Color10 = "#98bb6c";
          Color11 = "#e6c384";
          Color12 = "#7fb4ca";
          Color13 = "#938aa9";
          Color14 = "#7aa89f";
          Color15 = "#dcd7ba";
        };
      };
    };
  };
}
