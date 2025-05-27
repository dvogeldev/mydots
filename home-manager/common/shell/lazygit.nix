_: {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        theme = {
          lightTheme = false;
          activeBorderColor = ["#a6e3a1" "bold"];
          inactiveBorderColor = ["#cdd6f4"];
          selectedLineBgColor = ["#313244"];
        };
        showCommandLog = true;
        showFileTree = true;
        scrollHeight = 10;
      };
      git = {
        paging = {
          colorArg = "always";
          useConfig = false;
        };
        commit = {
          signOff = false;
        };
        merging = {
          manualCommit = false;
          args = "--no-ff";
        };
      };
      keybinding = {
        universal = {
          quit = "q";
          return = "<esc>";
          togglePanel = "<tab>";
        };
      };
    };
  };
}
