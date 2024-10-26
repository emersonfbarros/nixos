{ pkgs, ... }:

let
  micIcon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/emersonfbarros/dotfiles/refs/heads/main/mako/.config/mako/icons/mic.svg";
    sha256 = "075b1x49lsn1gn3734l1dipg8y4wz8r9ngcn0lhqlwhc43vbqccf";
  };

  micOffIcon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/emersonfbarros/dotfiles/refs/heads/main/mako/.config/mako/icons/mic_off.svg";
    sha256 = "0wgz2lr6ghm8n8mawkhbr89g209jg5z4gpwbk88sipwjva4wd1qm";
  };

  chsmicScript = pkgs.writeShellScriptBin "chmic" ''
    send_notification() {
      MIC_LEVEL=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2*100}')
      if [[ MIC_LEVEL -gt 0 ]]
        then
          ${pkgs.libnotify}/bin/notify-send "Mic level: $MIC_LEVEL%" -h int:value:"$MIC_LEVEL" \
            -h string:x-canonical-private-synchronous:sys-notify -u normal \
            -i ${micIcon}
      else
        ${pkgs.libnotify}/bin/notify-send "Mic is off: $MIC_LEVEL%" -h int:value:"$MIC_LEVEL" \
          -h string:x-canonical-private-synchronous:sys-notify -u normal \
          -i ${micOffIcon}
      fi
    }

    case $1 in
    up)
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%+
        send_notification
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-
        send_notification
        ;;
    esac
  '';
in
{
  home.packages = [ chsmicScript ];
}
