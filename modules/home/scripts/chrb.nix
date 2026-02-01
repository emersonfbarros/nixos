{
  flake.modules.homeManager.chrb =
    { pkgs, ... }:
    let
      brightnessHighIcon = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/emersonfbarros/dotfiles/main/mako/.config/mako/icons/brightness-high.svg";
        sha256 = "1kprc48cvqxsw1yphbs64hdrb8rgxvcvj0f4pjsixyx3j6rlr6fq";
      };

      brightnessLowIcon = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/emersonfbarros/dotfiles/main/mako/.config/mako/icons/brightness-low.svg";
        sha256 = "15phzhq835h88y9sml1klf0c1c59r7kgywxlxsp498y73rcja12g";
      };

      getBrightness = ''${pkgs.brightnessctl}/bin/brightnessctl | sed -En "s/.*\\(([0-9]+)%\\).*/\\1/p"'';

      chbrScript = pkgs.writeShellScriptBin "chbr" ''
        send_notification() {
          BRIGHTNESS=$(${getBrightness})
          if [[ $BRIGHTNESS -gt 50 ]]
            then
              ICON="${brightnessHighIcon}"
            else
              ICON="${brightnessLowIcon}"
          fi
          ${pkgs.libnotify}/bin/notify-send "Brightness: $BRIGHTNESS%" -h int:value:"$BRIGHTNESS" \
            -h string:x-canonical-private-synchronous:sys-notify -u normal -i "$ICON"
        }

        case $1 in
        up)
          ${pkgs.brightnessctl}/bin/brightnessctl set 5%+
          send_notification
          ;;
        down)
          CURR_BRIGHTNESS=$(${getBrightness})
          if [[ $CURR_BRIGHTNESS -gt 5 ]]
            then
              ${pkgs.brightnessctl}/bin/brightnessctl set 5%-
              send_notification
            else
              send_notification
          fi
          ;;
        esac
      '';
    in
    {
      home.packages = [ chbrScript ];
    };
}
