{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    swayidle
    swayimg
    autotiling
    cliphist
    wl-clipboard
  ];

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = true;
    config = rec {
      modifier = "Mod4";
      terminal = "${pkgs.kitty}/bin/kitty";
      menu = "${pkgs.tofi}/bin/tofi-drun --drun-launch=true";
      startup = [
        { command = "${pkgs.autotiling}/bin/autotiling"; }
        # { command = "${pkgs.gammastep}/bin/gammastep"; }
        { command = "${pkgs.networkmanagerapplet}/bin/nm-applet"; }
        {
          command = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
        }
        {
          command = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store";
        }
        {
          command = ''
            ${pkgs.swayidle}/bin/swayidle -w \
              timeout 300 'swaylock -f' \
              timeout 420 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
              timeout 540 'systemctl suspend' before-sleep 'swaylock -f'
          '';
        }
      ];

      input = {
        "type:keyboard" = {
          xkb_layout = "us,br";
          xkb_options = "grp:alt_shift_toggle";
        };
        "1739:32402:DELL0767:00_06CB:7E92_Touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };

      defaultWorkspace = "1";

      workspaceOutputAssign =
        let
          mkAssignments =
            output: workspaces:
            map (ws: {
              output = output;
              workspace = toString ws;
            }) workspaces;
        in
        mkAssignments "eDP-1" [
          1
          2
          3
          4
          5
        ]
        ++ mkAssignments "HDMI-A-1" [
          5
          6
          7
          8
          9
          10
        ];

      keybindings = lib.mkOptionDefault {
        "${modifier}+b" = "exec ${pkgs.firefox}/bin/firefox";

        "${modifier}+Shift+b" = "exec sway bar mode toggle";

        "${modifier}+p" = "exec tofi-power";

        "${modifier}+y" = "exec yt";

        "${modifier}+u" = "exec tofi-web-search";

        "Print" = ''exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -'';

        "${modifier}+c" = ''
          exec ${pkgs.cliphist}/bin/cliphist list | \
            ${pkgs.tofi}/bin/tofi --prompt-text "Clipboard:  " | \
            ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy
        '';

        "${modifier}+q" = "kill";

        "${modifier}+Shift+q" = ''
          exec swaynag -t warning \
            -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' \
            -B 'Yes, exit sway' \
            'swaymsg exit'
        '';

        # Media keys
        "XF86MonBrightnessDown" = "exec chbr down";
        "XF86MonBrightnessUp" = "exec chbr up";

        "XF86AudioRaiseVolume" = "exec chspk up";
        "XF86AudioLowerVolume" = "exec chspk down";
        "XF86AudioMute" = "exec chspk mute";

        "Shift+XF86AudioRaiseVolume" = "exec chmic up";
        "Shift+XF86AudioLowerVolume" = "exec chmic down";
      };

      gaps = {
        inner = 2;
        smartGaps = true;
      };

      window = {
        titlebar = false;
        hideEdgeBorders = "smart";
      };

      floating = {
        titlebar = false;
        criteria = [
          {
            title = "Steam - Update News";
          }
          {
            app_id = "org.pulseaudio.pavucontrol";
          }
          {
            app_id = ".blueman-manager-wrapped";
          }
          {
            app_id = "nm-connection-editor";
          }
        ];
      };

      bars = [
        {
          position = "top"; # Changed from bottom to top
          mode = "dock";
          extraConfig = "modifier ${modifier}";

          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
    };

    extraConfig = ''
      exec systemctl --user set-environment XDG_CURRENT_DESKTOP=sway
      exec systemctl --user import-environment DISPLAY \
        SWAYSOCK \
        WAYLAND_DISPLAY \
        XDG_CURRENT_DESKTOP

      exec hash dbus-update-activation-environment 2>/dev/null && \
          dbus-update-activation-environment --systemd DISPLAY \
              SWAYSOCK \
              XDG_CURRENT_DESKTOP=sway \
              WAYLAND_DISPLAY
    '';

    extraSessionCommands = ''
      export GDK_BACKEND=wayland,x11
      export QT_QPA_PLATFORM=wayland
      export QT_AUTO_SCREEN_SCALE_FACTOR=1
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export SDL_VIDEODRIVER=wayland
      export CLUTTER_BACKEND=wayland
      export WLR_NO_HARDWARE_CURSORS=1
      export XDG_SESSION_TYPE=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';

    # extraOptions = [  "--my-next-gpu-wont-be-nvidia" ];
  };
}
