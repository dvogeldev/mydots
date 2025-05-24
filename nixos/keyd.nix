{
  config,
  pkgs,
  ...
}: {
  # Add keyd service and configuration
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        settings = {
          main = {
            capslock = "overload(control, esc)";
            esc = "capslock";
          };
        };
      };
    };
  };
}
