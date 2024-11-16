{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    sway
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
        { command = "${pkgs.gammastep}/bin/gammastep"; }
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

        "Print" = ''exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -'';

        "${modifier}+c" = ''
          exec ${pkgs.cliphist}/bin/cliphist list | \
            ${pkgs.tofi}/bin/tofi --prompt-text "Clipboard:  " | \
            ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-paste
        '';

        # Media keys
        "XF86MonBrightnessDown" = "exec chbr down";
        "XF86MonBrightnessUp" = "exec chbr up";

        "XF86AudioRaiseVolume" = "exec chspk up";
        "XF86AudioLowerVolume" = "exec chspk down";
        "XF86AudioMute" = "exec chspk mute";
      };

      gaps = {
        inner = 2;
        smartGaps = true;
      };

      window = {
        titlebar = false;
        hideEdgeBorders = "smart";
      };

      floating.titlebar = false;

      # You can add more Sway config options here
      bars = [
        {
          position = "top"; # Changed from bottom to top
          mode = "dock";
          extraConfig = "modifier ${modifier}";

          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
      # startup = [];
    };
    extraConfig = ''
      exec systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service
    '';
  };
}
