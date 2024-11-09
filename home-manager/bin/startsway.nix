{ pkgs, ... }:
let
  startSway = pkgs.writeShellScriptBin "start-sway" ''
    export GDK_BACKEND=wayland,x11
    export QT_QPA_PLATFORM=wayland,xcb
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export SDL_VIDEODRIVER=wayland
    export CLUTTER_BACKEND=wayland
    export WLR_NO_HARDWARE_CURSORS=1
    export XDG_SESSION_TYPE=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
    export MOZ_ENABLE_WAYLAND=1

    ${pkgs.sway}/bin/sway
  '';
in
{
  home.packages = [ startSway ];
}
