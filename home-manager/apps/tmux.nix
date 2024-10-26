{
  programs.tmux = {
    enable = true;

    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"
      # status bar style
      set -g status-position top
      set -g status-right-length 80
      set -g status-left-length 80
      set -g status-left "#[bold][#S]  "
      set -g window-status-current-style "fg=#31748F bold"
      set -g window-status-style "fg=#908CAA"
      set -g status-right "%a %b %d  %R "
      # some settings
      set -g base-index 1
      set -g detach-on-destroy off
      set -g escape-time 0
      set -g history-limit 100000
      set -g renumber-windows on
      set -g set-clipboard on
      set -g default-terminal "''${TERM}"
      set -g mouse on
    '';
  };
}
