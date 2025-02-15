{ config, ... }:
{
  services.mako =
    let
      inherit (config.lib.stylix) colors;
    in
    {
      enable = true;
      defaultTimeout = 5000;
      padding = "5";
      borderSize = 2;
      maxIconSize = 64;
      layer = "overlay";
      font = "Noto Sans 10";
      backgroundColor = "#${colors.base01}";
      textColor = "#${colors.base05}";
      borderColor = "#${colors.base0D}";
      progressColor = "over #${colors.base02}";
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
