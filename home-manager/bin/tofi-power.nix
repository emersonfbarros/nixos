{ pkgs, ... }:
let
  powerScript = pkgs.writeShellScriptBin "tofi-power" ''
    chosen=$(printf "  Power Off\n  Restart\n󰍃  Log Out\n  Lock\n󰒲  Sleep" | ${pkgs.tofi}/bin/tofi --prompt-text "Power Menu:  ")

    case "$chosen" in
            "  Power Off") systemctl poweroff ;;
            "  Restart") systemctl reboot ;;
            "󰍃  Log Out") ${pkgs.sway}/bin/sway exit ;;
            "  Lock") ${pkgs.swaylock}/bin/swaylock -f -c 000000;;
            "󰒲  Sleep") ${pkgs.swaylock}/bin/swaylock -f -c 000000 && systemctl suspend ;;
            *) exit 1 ;;
    esac
  '';
in
{
  home.packages = [ powerScript ];
}
