{ config, ... }:
{
  programs.swaylock.settings =
    let
      colors = config.lib.stylix.colors;
    in
    {
      # Background color
      color = "#191724";

      # Layout text colors
      layout-bg-color = "#00000000";
      layout-border-color = "#00000000";
      layout-text-color = "#${colors.base06}";

      # Text color
      text-color = "#${colors.base0B}";
      text-clear-color = "#${colors.base0C}";
      text-caps-lock-color = "#${colors.base0E}";
      text-ver-color = "#${colors.base0D}";
      text-wrong-color = "#${colors.base08}";

      # Highlight segments
      bs-hl-color = "#${colors.base00}66";
      key-hl-color = "#${colors.base0B}";
      caps-lock-bs-hl-color = "#${colors.base00}66";
      caps-lock-key-hl-color = "#${colors.base0E}";

      # Highlight segments separator
      separator-color = "#00000000";

      # Inside of the indicator
      inside-color = "#${colors.base0B}55";
      inside-clear-color = "#${colors.base0C}55";
      inside-caps-lock-color = "${colors.base09}55";
      inside-ver-color = "#${colors.base0D}55";
      inside-wrong-color = "#${colors.base08}55";

      # Line between the inside and ring
      line-color = "#${colors.base0B}11";
      line-clear-color = "#${colors.base0c}11";
      line-caps-lock-color = "#${colors.base0E}11";
      line-ver-color = "#${colors.base0D}11";
      line-wrong-color = "#${colors.base08}11";

      # Indicator ring
      ring-color = "#${colors.base0B}aa";
      ring-clear-color = "#${colors.base0C}aa";
      ring-caps-lock-color = "#${colors.base0E}aa";
      ring-ver-color = "#${colors.base0D}aa";
      ring-wrong-color = "#${colors.base08}aa";

    };
}
