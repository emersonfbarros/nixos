{
  flake.modules.homeManager.zsh =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      programs.zsh = {
        enable = true;

        shellAliases = {
          ls = "${pkgs.eza}/bin/eza --group-directories-first --icons=always";
          ll = "ls -lh --git";
          la = "ll -a";
          lt = "ll --tree --level=2";
          cat = "bat";
          cl = "unset NEW_LINE_BEFORE_PROMPT && clear";
        };

        history = {
          append = true;
          expireDuplicatesFirst = true;
          extended = true;
          findNoDups = true;
          ignoreAllDups = true;
          saveNoDups = true;
          ignoreDups = true;
          ignoreSpace = true;
          path = config.home.homeDirectory + "/.zsh_history";
          save = 50000;
          share = true;
          size = 50000;
        };

        historySubstringSearch = {
          enable = true;
          searchUpKey = "^[[A";
          searchDownKey = "^[[B";
        };

        initContent = lib.mkMerge [
          (lib.mkBefore ''
            # Load colors
            autoload -Uz colors && colors

            bindkey -s '^x' '^usource $HOME/.zshrc\n'
            bindkey "^R" history-incremental-search-backward
            bindkey '^H' backward-kill-word # Ctrl + Backspace to delete a whole word.
            bindkey "^?" backward-delete-char
          '')
          (lib.mkAfter ''
            # Disable beep
            unsetopt BEEP

            # Additional history options
            setopt BANG_HIST
            setopt HIST_REDUCE_BLANKS
            setopt HIST_VERIFY

            autoload -U up-line-or-beginning-search
            autoload -U down-line-or-beginning-search
            zle -N up-line-or-beginning-search
            zle -N down-line-or-beginning-search

            # Other options
            setopt AUTO_CD
            setopt GLOB_DOTS
            setopt NOMATCH
            setopt MENU_COMPLETE
            setopt EXTENDED_GLOB
            setopt INTERACTIVE_COMMENTS

            # Highlight settings
            zle_highlight=('paste:none')

            # Transient prompt with starship
            setopt prompt_subst
            zle-line-init() {
              zle -K viins
              echo -ne '\e[6 q' # beam

              emulate -L zsh
              [[ $CONTEXT == start ]] || return 0
              while true; do
                zle .recursive-edit
                local -i ret=$?
                [[ $ret == 0 && $KEYS == $'\4' ]] || break
                [[ -o ignore_eof ]] || exit 0
              done
              local saved_prompt=$PROMPT
              local saved_rprompt=$RPROMPT
              PROMPT="%{$fg_bold[green]%}❯ %{$reset_color%}"
              RPROMPT=""
              zle .reset-prompt
              PROMPT=$saved_prompt
              RPROMPT=$saved_rprompt
              if (( ret )); then
                zle .send-break
              else
                zle .accept-line
              fi
              return ret
            }
            zle -N zle-line-init

            # Precmd for newline before prompt
            precmd() {
              if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
                  NEW_LINE_BEFORE_PROMPT=1
              elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
                  echo ""
              fi
            }

            # Editing commands inside neovim
            bindkey -v # Enable vi keybings
            export KEYTIMEOUT=1
            export VI_MODE_SET_CURSOR=true

            autoload -Uz edit-command-line
            zle -N edit-command-line
            bindkey -M vicmd 'v' edit-command-line

            function zle-keymap-select {
              if [[ ''${KEYMAP} == vicmd ]]; then
                echo -ne '\e[2 q' # block
              else
                echo -ne '\e[6 q' # beam
              fi
            }
            zle -N zle-keymap-select

            # Yank to system clipboard
            function vi-yank-clipboard {
              zle vi-yank
              if command -v pbcopy &> /dev/null; then
                echo "$CUTBUFFER" | pbcopy -i
              elif command -v wl-copy &> /dev/null; then
                echo "$CUTBUFFER" | wl-copy
              fi
            }
            zle -N vi-yank-clipboard
            bindkey -M vicmd 'y' vi-yank-clipboard

            export PATH="$HOME/.local/bin:$PATH"
            export PATH="$HOME/.npm-global/bin:$PATH"
          '')
        ];

        completionInit = ''
          autoload -Uz compinit
          zstyle ':completion:*' menu no
          zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
          zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
          zmodload zsh/complist
          _comp_options+=(globdots) # Include hidden files.
          zle_highlight=('paste:none')
          for dump in "''${ZDOTDIR:-$HOME}/.zcompdump"(N.mh+24); do
            compinit
          done
          compinit -C
        '';

        # Plugins
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        plugins = [
          {
            name = "fzf-tab";
            src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
          }
        ];

        profileExtra = ''[ "$(tty)" = "/dev/tty1" ] && exec sway'';
      };
    };
}
