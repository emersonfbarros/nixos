{ pkgs, ... }:
let
  ztScript = pkgs.writeShellScriptBin "zt" ''
    if [[ $# -eq 1 ]]; then
        SELECTED=$1
    else
        SELECTED=$(${pkgs.fd}/bin/fd --exact-depth 1 --type d --color never --hidden \
          . ~/Repos/dotfiles ~/Repos/work ~/Repos ~/.config ~/.local ~/ \
          | ${pkgs.fzf}/bin/fzf --tmux 70%)
    fi

    if [[ -z $SELECTED ]]; then
        exit 0
    fi

    SESSION_NAME=$(basename "$SELECTED" | tr . _)

    if [[ -z $TMUX ]]; then
        ${pkgs.tmux}/bin/tmux new-session -As "$SESSION_NAME" -c "$SELECTED"
        exit 0
    fi

    if ! ${pkgs.tmux}/bin/tmux has-session -t="$SESSION_NAME" 2> /dev/null; then
        ${pkgs.tmux}/bin/tmux new-session -ds "$SESSION_NAME" -c "$SELECTED"
    fi

    ${pkgs.tmux}/bin/tmux switch-client -t "$SESSION_NAME"
  '';
in
{
  home.packages = [ ztScript ];
}
