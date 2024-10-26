{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    initExtra = ''
      if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)"
      fi
    '';
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --group-directories-first --icons=always";
      ll = "ls -lh --git";
      la = "ll -a";
      lt = "ll --tree --level=2";
      cat = "bat";
    };
  };
}
