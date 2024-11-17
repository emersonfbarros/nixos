{ config, ... }:
{
  services.mako =
    let
      colors = config.lib.stylix.colors;
    in
    {
      enable = true;
      defaultTimeout = 5000;
      padding = "15";
      borderSize = 2;
      maxIconSize = 48;
      layer = "overlay";
      actions = true;
      font = "DejaVu Sans 10";
      backgroundColor = "#${colors.base01}";
      textColor = "#${colors.base05}";
      borderColor = "#${colors.base02}";
      progressColor = "#${colors.base0F}";
      extraConfig = ''
        on-button-left=dismiss
        on-button-middle=none
        on-button-right=dismiss-all
        on-touch=dismiss
        text-alignment=center
        history=1

        [urgency=low]
        default-timeout=2000

        [urgency=high]
        border-color=#${colors.base08}
        text-color=#${colors.base08}
        default-timeout=0

        [category=mpd]
        border-color=#${colors.base09}
        default-timeout=2000
        group-by=category
      '';
    };

  stylix.targets.mako.enable = false;
}
