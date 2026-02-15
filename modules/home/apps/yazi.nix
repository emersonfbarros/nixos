{
  flake.modules.homeManager.yazi =
    { lib, pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;

        settings = {
          preview = {
            max_width = 1200;
            max_height = 1000;
          };
          manager = {
            show_hidden = true;
          };
          opener = {
            open = [
              {
                run = ''${lib.getExe' pkgs.xdg-utils "xdg-open"} "$@"'';
                desc = "Open";
              }
            ];
          };
          open = {
            rules = [
              {
                name = "*";
                use = "open";
              }
            ];
          };
        };
      };
    };
}
