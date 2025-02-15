{ pkgs, config, ... }:
let
  inherit (config.lib.stylix) colors;

  workspace-usage = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "workspace_usage";
    version = "unstable-2024-12-14";
    src = pkgs.fetchFromGitHub {
      owner = "sjdonado";
      repo = "tmux-workspace-usage";
      rev = "master";
      sha256 = "sha256-w0JHbr3EJi4kPMYpGUoOFq4dC42GqBUr3FuvD0k/n4A=";
    };
  };
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
    terminal = "tmux-256color";
    extraConfig = ''
    set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
    set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0


      # status bar style
      set -g status-position top
      set -g status-right-length 80
      set -g status-left-length 80

      # Status left: maintain the original icon color, update session name style
      set -g status-left "#[fg=#${colors.base0A},bold] #S"

      # Window styles
      set -g window-status-current-style "fg=#${colors.base04},bold"
      set -g window-status-style "fg=#${colors.base03}"
      setw -g window-status-current-format " #I:#W#[fg=#${colors.base04},bold]#{?window_flags,#{window_flags},} "
      setw -g window-status-format " #I:#W#[fg=#${colors.base03}]#{?window_flags,#{window_flags},} "


      # Centralize window indicators
      set -g status-justify absolute-centre

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
        plugin = tmuxPlugins.fuzzback;
        extraConfig = ''
          set -g @fuzzback-popup 1
          set -g @fuzzback-popup-size '90%'
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
      {
        plugin = tmuxPlugins.mode-indicator;
        extraConfig = ''
          # prompt to display when tmux prefix key is pressed
          set -g @mode_indicator_prefix_prompt '󰂺 WAIT '

          # prompt to display when tmux is in copy mode
          set -g @mode_indicator_copy_prompt '󰂺 COPY '

          # prompt to display when tmux has synchronized panes
          set -g @mode_indicator_sync_prompt '󰂺 SYNC '

          # prompt to display when tmux is in normal mode
          set -g @mode_indicator_empty_prompt '󰂺 TMUX '

          # style values for prefix prompt
          set -g @mode_indicator_prefix_mode_style 'fg=#${colors.base06},bold'

          # style values for copy prompt
          set -g @mode_indicator_copy_mode_style 'fg=#${colors.base0B},bold'

          # style values for sync prompt
          set -g @mode_indicator_sync_mode_style 'fg=#${colors.base09},bold'

          # style values for empty prompt
          set -g @mode_indicator_empty_mode_style 'fg=#${colors.base0C}'

          # if I don't declare it here it won't be sourced on tmux startup
          set -g status-right "#{tmux_mode_indicator} #[fg=#${colors.base08}] #{workspace_usage}" # right side items
        '';
      }
      {
        plugin = workspace-usage;
        extraConfig = ''
          set -g @workspace_usage_processes 'tmux|nvim|go|gopls|cargo|rustc|rust-analyzer|dlv|dlv-dap|code-lldb|rust-lldb|lua-language-server|nixd|bash-language-server|taplo|docker-langserver|docker-compose-langserver'

          set -g @workspace_usage_mem 'on'
          set -g @workspace_usage_cpu 'on'

          set -g @workspace_usage_interval_delay 10
        '';
      }
    ];
  };
}
