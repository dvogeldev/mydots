{
  config,
  pkg,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true; # Use fish integration
    settings = {
      manager = {
        show_hidden = true;
        sort_by = "alphabetical";
        sort_reverse = false;
      };
      preview = {
        max_width = 120;
        max_height = 40;
        preview_images = true;
      };
      theme = "catppuccin-mocha";
    };
    keymap.manager.prepend_keymap = [
      {
        on = "q";
        run = "quit";
        desc = "Quit yazi";
      }
      {
        on = "h";
        run = "back";
        desc = "Go back";
      }
      {
        on = "l";
        run = "open";
        desc = "Open file/directory";
      }
      {
        on = ".";
        run = "toggle_hidden";
        desc = "Toggle hidden files";
      }
    ];
  };
}
