{ pkgs, config, ... }:
let
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
      set -g window-status-current-style "fg=#${colors.base04} bold" # current window style
      set -g window-status-style "fg=#${colors.base03}"              # other windows style
      set -g status-right-style "fg=#${colors.base06}"
      set -g status-right "%a %b %d  %R " # right side items

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
    ];
  };
}
