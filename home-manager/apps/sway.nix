{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    sway
    swaylock
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
        {
          command = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
        }
        {
          command = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store";
        }
        {
          command = ''
            ${pkgs.swayidle} -w \
              timeout 300 'swaylock' \
              timeout 420 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
              timeout 540 'systemctl suspend' before-sleep 'swaylock'
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

      defaultWorkspace = "workspace number 1";
      workspaceOutputAssign = [
        {
          output = "eDP-1";
          workspace = "workspace number 1";
        }
        {
          output = "eDP-1";
          workspace = "workspace number 2";
        }
        {
          output = "eDP-1";
          workspace = "workspace number 3";
        }
        {
          output = "eDP-1";
          workspace = "workspace number 4";
        }
        {
          output = "eDP-1";
          workspace = "workspace number 5";
        }
        {
          output = "HDMI-A-1";
          workspace = "workspace number 5";
        }
        {
          output = "HDMI-A-1";
          workspace = "workspace number 6";
        }
        {
          output = "HDMI-A-1";
          workspace = "workspace number 7";
        }
        {
          output = "HDMI-A-1";
          workspace = "workspace number 8";
        }
        {
          output = "HDMI-A-1";
          workspace = "workspace number 9";
        }
        {
          output = "HDMI-A-1";
          workspace = "workspace number 10";
        }
      ];

      keybindings = lib.mkOptionDefault {
        "${modifier}+b" = "exec ${pkgs.firefox}/bin/firefox";

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
          hiddenState = "hide";

          statusCommand = "${pkgs.i3status}/bin/i3status";

          fonts = {
            names = [
              "Lilex Nerd Font Mono"
            ];
            size = 8.0;
          };

          # Additional bar settings
          workspaceButtons = true;
          workspaceNumbers = true;
          trayOutput = "primary";
        }
      ];
      # startup = [];
    };
    extraConfig = ''
      exec systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service
    '';
  };
}
