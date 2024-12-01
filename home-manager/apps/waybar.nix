{ pkgs, config, ... }:
{
  programs.waybar =
    let
      colors = config.lib.stylix.colors;
    in
    {
      enable = true;

      settings = {
        mainBar = {
          ipc = true;
          layer = "top";
          position = "top";
          mode = "dock";
          height = 15;
          modules-left = [
            "sway/workspaces"
            "custom/scratch"
            "sway/mode"
            "sway/window"
          ];
          modules-center = [ ];
          modules-right = [
            "sway/language"
            "pulseaudio#input"
            "pulseaudio#output"
            "clock"
            "custom/hours"
            "group/hardware"
            "custom/battery"
            "tray"
          ];

          "sway/workspaces" = {
            "disable-scroll" = true;
            "disable-markup" = true;
            "format" = "{index}";
          };

          "format" = "{}";
          "sway/window" = {
            "max-length" = 150;
          };

          "custom/scratch" = {
            "interval" = 3;
            "exec" = ''
              swaymsg -t get_tree \
              | jq 'recurse(.nodes[]) | first(select(.name=="__i3_scratch")) | .floating_nodes | length | select(. >= 0)';
            '';
            "format" = "^{}";
            "on-click" = "swaymsg 'scratchpad show'";
            "on-click-right" = "swaymsg 'move scratchpad'";
          };

          "tray" = {
            "icon-size" = 16;
            "spacing" = 10;
          };

          "sway/language" = {
            "format" = "  {short} {variant}";
          };

          "pulseaudio#input" = {
            "format-source" = "󰍬 {volume}%";
            "format-source-muted" = "󰍭 Mute";
            "format" = "{format_source}";
            "scroll-step" = 1;
            "smooth-scrolling-threshold" = 1;
            "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
            "on-click-right" = "pavucontrol -t 4";
            "on-scroll-up" = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%+";
            "on-scroll-down" = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%-";
          };

          "pulseaudio#output" = {
            "format" = "{icon} {volume}%";
            "format-muted" = "󰝟 Mute";
            "format-icons" = {
              "default" = [
                "󰕿"
                "󰖀"
                "󰕾"
              ];
            };
            "max-volume" = 130;
            "scroll-step" = 2;
            "smooth-scrolling-threshold" = 1;
            "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "on-click-right" = "pavucontrol -t 3";
            "on-scroll-up" = "wpctl set-volume -l 1.3 @DEFAULT_AUDIO_SINK@ 5%+";
            "on-scroll-down" = "wpctl set-volume -l 1.3 @DEFAULT_AUDIO_SINK@ 5%-";
          };

          "clock" = {
            "format" = "󰃭 {:%a %b %d}";
            "interval" = 3600;
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            "calendar" = {
              "mode" = "month";
              "mode-mon-col" = 3;
              "weeks-pos" = "right";
              "on-scroll" = 1;
              "format" = {
                "months" = "<span color='#${colors.base05}'><b>{}</b></span>";
                "days" = "<span color='#${colors.base03}'><b>{}</b></span>";
                "weeks" = "<span color='#${colors.base0F}'><b>W{}</b></span>";
                "weekdays" = "<span color='#${colors.base0A}'><b>{}</b></span>";
                "today" = "<span color='#${colors.base08}'><b><u>{}</u></b></span>";
              };
            };
            "actions" = {
              "on-click-right" = "mode";
              # "on-scroll-up"= "tz_up";
              # "on-scroll-down"= "tz_down";
              "on-scroll-up" = "shift_up";
              "on-scroll-down" = "shift_down";
            };
          };

          "custom/hours" = {
            "interval" = 5;
            "exec" = pkgs.writeShellScript "hours" ''
              icons=("󱑋 " "󱑌 " "󱑍 " "󱑎 " "󱑏 " "󱑐 " "󱑑 " "󱑒 " "󱑓 " "󱑔 " "󱑕 " "󱑖 ")
              index_by_hour=$(($(date '+%l') - 1))
              echo "''${icons[$index_by_hour]}$(date '+%R')"
            '';
            "format" = "{}";
          };

          "group/hardware" = {
            "orientation" = "inherit";
            "drawer" = {
              "transition-duration" = 500;
            };
            "modules" = [
              "memory"
              "cpu"
              "disk"
            ];
          };

          "cpu" = {
            "interval" = 10;
            "format" = " {}%";
            "max-length" = 10;
          };

          "memory" = {
            "interval" = 20;
            "format" = " {}%";
            "max-length" = 7;
            "tooltip-format" = "{used:0.2f}G/{total:0.2f}G";
          };

          "disk" = {
            "interval" = 300;
            "format" = " {percentage_used}%";
            "path" = "/";
          };

          "custom/battery" = {
            "interval" = 30;
            "exec" = pkgs.writeShellScript "battery" ''
              battery_info=$(upower -i "/org/freedesktop/UPower/devices/battery_BAT1")
              is_charging=$(echo "$battery_info" | grep state | awk '{print $2}')

              if [[ "$is_charging" == "charging" ]]; then
                icons=("󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")
              else
                icons=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
              fi

              charged_value=$(echo "$battery_info" | grep percentage | awk '{print $2}')

              index=''${charged_value::-2}

              echo "''${icons[$index]} $charged_value"
            '';
            "format" = "{}";
          };
        };
      };

      style = ''
        * {
          font-family: "JetBrainsMono NF";
          font-size: 13.5px;
          min-height: 0;
          margin: 0;
          padding: 0;
        }

        window#waybar {
          background-color: #${colors.base02};
          color: #${colors.base05};
        }

        .modules-left {
          background-color: #${colors.base00};
          padding: 0px 0px 0px 0px;
        }

        .modules-right {
          background-color: #${colors.base00};
          padding: 0px 5px 0px 0px;
        }

        #custom-scratch {
          background-color: #${colors.base00};
          color: #${colors.base03};
          padding: 0px 9px 0px 9px;
        }

        #workspaces button {
          padding: 0px 10px 0px 10px;
          min-width: 1px;
          color: #${colors.base05};
        }

        #workspaces button.focused {
          padding: 0px 10px 0px 10px;
          background-color: #${colors.base02};
          border-radius: 0px;
        }

        #mode {
          background-color: #${colors.base08};
          color: #${colors.base05};
          padding: 0px 5px 0px 5px;
          border: 1px solid #${colors.base00};
        }

        #window {
          color: #${colors.base05};
          background-color: #${colors.base02};
          padding: 0px 10px 0px 10px;
        }

        window#waybar.empty #window {
          background-color: transparent;
          color: transparent;
        }

        window#waybar.empty {
          background-color: #${colors.base00};
        }

        #language,
        #pulseaudio.input,
        #pulseaudio.output,
        #custom-hours,
        #custom-battery,
        #cpu,
        #memory,
        #disk {
          padding: 0px 10px 0px 10px;
        }

        #clock {
          margin: 0px 10px 0px 10px;
        }

        #tray {
          padding: 0px 6px 0px 4px;
          margin: 0px 4px 0px 4px;
        }
      '';
    };

  stylix.targets.waybar.enable = false;
}
