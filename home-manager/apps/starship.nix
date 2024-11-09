{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        ''''${custom.gitparenthesis}''
        "$git_state"
        "$git_status"
        "$fill"
        "$golang"
        "$rust"
        "$nodejs"
        "$python"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];

      username = {
        show_always = true;
        format = ''[\[](fg:061)$user[@](red)'';
      };

      hostname = {
        format = ''$hostname '';
        ssh_only = false;
        disabled = false;
      };

      directory = {
        format = ''[($path)](blue)[\]](fg:061) '';
        truncation_length = 3;
        truncation_symbol = ''…/'';
      };

      character = {
        format = ''$symbol '';
        success_symbol = ''[❯](green)'';
        error_symbol = ''[❯](red)'';
        vimcmd_symbol = ''[❮](fg:035)'';
      };

      git_branch = {
        format = ''[](fg:173)[\(](fg:061)[$branch](fg:139)'';
      };

      git_status = {
        format = ''$ahead_behind$all_status[\)](fg:061)'';
        ahead = ''''\ [⇡$count](italic green)'';
        behind = ''''\ [⇣$count](italic red)'';
        diverged = ''''\ ⇕⇡''${ahead_count}⇣''${behind_count}'';
        conflicted = ''''\ [~$count](italic bright-magenta)'';
        untracked = ''''\ [?$count](italic bright-yellow)'';
        stashed = ''''\ [≡$count](italic bright-black)'';
        modified = ''''\ [!$count](italic fg:215)'';
        staged = ''''\ [+$count](italic bright-cyan)'';
        renamed = ''''\ [↪$count](italic bright-blue)'';
        deleted = ''''\ [✕$count](italic red)'';
      };

      custom.gitparenthesis = {
        format = ''[$output](fg:061)'';
        command = ''echo ")"'';
        when = ''test $(git rev-parse --is-inside-work-tree) = "false" '';
      };

      git_state = {
        format = ''\([$state( $progress_current/$progress_total)](fg:218)\) '';
      };

      fill = {
        symbol = ''''\ '';
      };

      cmd_duration = {
        format = ''[took $duration](yellow) '';
      };

      golang = {
        symbol = '' '';
        format = ''([$symbol($version )](fg:#79D4FD))'';
      };

      rust = {
        symbol = '' '';
        format = ''([$symbol($version )](fg:#F18B41))'';
      };

      nodejs = {
        symbol = '' '';
        format = ''([$symbol($version )](fg:#6CC24A))'';
      };

      lua = {
        symbol = ''󰢱 '';
        format = ''([$symbol($version )](fg:#010080))'';
      };

      python = {
        symbol = '' '';
        format = ''([$symbol($version )](fg:#3C77A8))'';
      };
    };
  };
}
