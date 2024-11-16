{ pkgs, config, ... }:
let
  pomodoro = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "pomodoro";
    version = "1.0.2";
    # version = "unstable-2024-11-09";
    src = pkgs.fetchFromGitHub {
      owner = "olimorris";
      repo = "tmux-pomodoro-plus";
      rev = "51fb321da594dab5a4baa532b53ea19b628e2822";
      sha256 = "sha256-LjhG2+DOAtLwBspOzoI2UDTgbUFWj7vvj6TQXqWw9z0=";
    };
  };

  colors = config.lib.stylix.colors;
in
{
  programs.tmux = {
    enable = true;

    prefix = "C-a";
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    historyLimit = 100000;
    mouse = true;
    terminal = "$TERM";
    extraConfig = ''
      # status bar style
      set -g status-position top
      set -g status-right-length 80
      set -g status-left-length 80
      set -g status-left "#[fg=#${colors.base0A},bold][#S]  "        # styles session name
      set -g window-status-current-style "fg=#${colors.base0B} bold" # current window style
      set -g window-status-style "fg=#${colors.base04}"              # other windows style
      set -g status-right "#{pomodoro_status}  #[fg=#${colors.base06}]%a %b %d  %R " # right side itens

      # extra settings
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g detach-on-destroy off
      set -g renumber-windows on
      set -g set-clipboard on
      set -g allow-passthrough on
      set -g visual-activity off
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      # Keybindings
      bind -n C-s run-shell 'zt' # popup for zt script

      unbind i
      bind-key i run-shell 'zt ~'

      unbind X
      bind-key X confirm-before -p "Kill current session? (y/n)" kill-session

      set-window-option -g mode-keys vi                    # vi keys for window
      bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
      bind-key -T copy-mode-vi 'y' send -X copy-selection  # copy text with "y"
      unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode after dragging with mouse

      # resize panes without pain
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5
    '';

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
      {
        plugin = pomodoro;
        extraConfig = ''
          set -g @pomodoro_notifications 'on'
          set -g @pomodoro_sound 'on'
          set -g @pomodoro_on "  "                       # The formatted output when the Pomodoro is running
          set -g @pomodoro_complete " 󰸞 "                 # The formatted output when the break is running
          set -g @pomodoro_pause " 󰏤 "                    # The formatted output when the Pomodoro/break is paused
          set -g @pomodoro_prompt_break " ⏲︎  break?"      # The formatted output when waiting to start a break
          set -g @pomodoro_prompt_pomodoro " ⏱︎  start?"   # The formatted output when waiting to start a Pomodoro
        '';
      }
    ];
  };
}
