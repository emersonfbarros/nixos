{ pkgs, ... }:
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
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      save = 50000;
      size = 50000;
      share = true;
      path = "$HOME/.zsh_history";
    };

    historySubstringSearch = {
      enable = true;
      searchUpKey = "^[[A";
      searchDownKey = "^[[B";
    };

    initExtraFirst = ''
      # Load colors
      autoload -Uz colors && colors

      bindkey -s '^x' '^usource $HOME/.zshrc\n'
      bindkey "^R" history-incremental-search-backward
      bindkey '^H' backward-kill-word # Ctrl + Backspace to delete a whole word.
      bindkey "^?" backward-delete-char
    '';

    initExtra = ''
      if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)"
      fi

      # Disable beep
      unsetopt BEEP

      # Additional history options
      setopt BANG_HIST
      setopt HIST_FIND_NO_DUPS
      setopt HIST_SAVE_NO_DUPS
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
    '';

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
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "master";
          sha256 = "sha256-gvZp8P3quOtcy1Xtt1LAW1cfZ/zCtnAmnWqcwrKel6w=";
        };
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "master";
          sha256 = "sha256-UQ4O0Nqa92BDnKw5UV72tXJsRIs2uCoXCELsnpZN3gE=";
        };
      }
    ];
  };
}
