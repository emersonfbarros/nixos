{
  flake.modules.homeManager.zt =
    { pkgs, ... }:
    let
      ztScript = pkgs.writeShellScriptBin "zt" ''
        if [[ $# -eq 1 ]]; then
          selected=$1
        else
          # Get the list of running sessions
          sessions=$(${pkgs.tmux}/bin/tmux list-sessions -F "#{session_name}: #{session_windows} window(s)" 2>/dev/null || true)

          # Get the list of directories and replace `/home/username` with `~`
          directories=$(${pkgs.fd}/bin/fd --exact-depth 1 --type d --color never --hidden \
            . ~/Repos/personal ~/Repos/work ~/.config ~/.local ~/ \
            | sed "s|^$HOME|~|")

          # Combine sessions and directories for fzf
          selected=$( (echo "$sessions"; echo "$directories") | ${pkgs.fzf}/bin/fzf --tmux 50%)
        fi

        if [[ -z $selected ]]; then
          exit 0
        fi

        if [[ $selected == *":"* ]]; then
          # The user selected a session; extract session name and switch to it
          session_name=$(echo "$selected" | awk -F: '{print $1}')
          ${pkgs.tmux}/bin/tmux switch-client -t "$session_name"
          exit 0
        fi

        # Convert `~` back to `$HOME` for the selected directory
        if [[ $selected == ~* ]]; then
          selected=$(echo "$selected" | sed "s|^~|$HOME|")
        fi

        # The user selected a directory; create or switch session
        session_name=$(basename "$selected" | tr . _)

        if [[ -z $TMUX ]]; then
          ${pkgs.tmux}/bin/tmux new-session -As "$session_name" -c "$selected"
          exit 0
        fi

        if ! ${pkgs.tmux}/bin/tmux has-session -t="$session_name" 2>/dev/null; then
          ${pkgs.tmux}/bin/tmux new-session -ds "$session_name" -c "$selected"
        fi

        ${pkgs.tmux}/bin/tmux switch-client -t "$session_name"
      '';
    in
    {
      home.packages = [ ztScript ];
    };
}
