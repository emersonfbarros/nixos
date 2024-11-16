{ pkgs, ... }:
let
  volUpIcon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/emersonfbarros/dotfiles/refs/heads/main/mako/.config/mako/icons/volume_up.svg";
    sha256 = "06rzwmvii18l840zgdzhxxydszs7myn8ls2sw9f9z7qgv3srafb0";
  };

  volDownIcon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/emersonfbarros/dotfiles/refs/heads/main/mako/.config/mako/icons/volume_down.svg";
    sha256 = "12nhr22xgpjprq6v1q1h5fbvx34kqzzs76r286zrspx26xig4wdm";
  };

  volMuteIcon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/emersonfbarros/dotfiles/refs/heads/main/mako/.config/mako/icons/volume_zero.svg";
    sha256 = "1309m7yhjd0d02mzi56lcwfkrfsfq6nv8minm16mdjhp6c18v0lz";
  };

  chspkScript = pkgs.writeShellScriptBin "chspk" ''
    send_notification() {
      VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}')
      if [[ $VOLUME -ge 50 ]]
        then
          ${pkgs.libnotify}/bin/notify-send "Volume: $VOLUME%" -h int:value:"$VOLUME" \
            -h string:x-canonical-private-synchronous:sys-notify -u low \
            -i ${volUpIcon} -t 2000
      elif [[ $VOLUME -lt 50 ]] && [[ $VOLUME -gt 0 ]]
        then
          ${pkgs.libnotify}/bin/notify-send "Volume: $VOLUME%" -h int:value:"$VOLUME" \
            -h string:x-canonical-private-synchronous:sys-notify -u low \
            -i ${volDownIcon} -t 2000
      elif [[ $VOLUME -eq 0 ]]
        then
          ${pkgs.libnotify}/bin/notify-send "Volume: $VOLUME%" -h int:value:"$VOLUME" \
            -h string:x-canonical-private-synchronous:sys-notify -u low \
            -i ${volMuteIcon} -t 2000
      fi
    }

    is_muted() {
      if echo "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)" | grep -q "[MUTED]"; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      fi
    }

    case $1 in
    up)
        is_muted # if the volume is muted, activate it
        wpctl set-volume -l 1.3 @DEFAULT_AUDIO_SINK@ 5%+
        send_notification
        ;;
    down)
        is_muted # if the volume is muted, activate it
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        send_notification
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        if echo "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F. '{print $2}')" | grep -q "[MUTED]"; then
          ${pkgs.libnotify}/bin/notify-send "Audio is Muted" -h string:x-canonical-private-synchronous:sys-notify \
            -u low -i ${volMuteIcon}
        else
          send_notification
        fi
        ;;
    esac
  '';
in
{
  home.packages = [ chspkScript ];
}
