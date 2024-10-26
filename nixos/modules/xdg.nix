{ pkgs, ... }:
# Configuring xdg portals, especially for screen sharing
{
  xdg = {
    portal = {
      enable = true;
      config.common.default = [
        "gtk"
        "wlr"
      ];
      wlr.enable = true;
      wlr.settings.screencast = {
        output_name = "eDP-1";
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk # gtk portal needed to make gtk apps happy
      ];
    };
    mime.enable = true;
  };
}
