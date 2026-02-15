{
  flake.modules.homeManager.tofi =
    { config, ... }:
    let
      inherit (config.lib.stylix) colors;
    in
    {
      programs.tofi = {
        enable = true;
        settings = {
          font = "IosevkaTerm NF";
          font-size = 10;

          anchor = "top";
          width = "100%";
          height = 21;
          horizontal = true;

          outline-width = 0;
          border-width = 0;
          min-input-width = 150;
          result-spacing = 15;
          padding-top = 2;
          padding-bottom = 0;
          padding-left = 0;
          padding-right = 0;

          prompt-text = ''" Run  "'';
          fuzzy-match = true;

          background-color = "#${colors.base00}";
          text-color = "#${colors.base05}";

          prompt-background = "#${colors.base02}";
          prompt-background-padding = "1, 5, 1, 5";
          prompt-color = "#${colors.base05}";

          selection-background = "#${colors.base02}";
          selection-background-padding = "1, 5, 1, 5";
          selection-color = "#${colors.base05}";
        };
      };

      stylix.targets.tofi.enable = false;
    };
}
