{ pkgs, ... }:
let
  kitab = pkgs.writeShellScriptBin "kitab" ''
    if [[ $# -eq 1 ]]; then
      directory=$1
    else
      directory=$(${pkgs.fd}/bin/fd --exact-depth 1 --type d --color never --hidden \
        . ~/Repos/dotfiles ~/Repos/work ~/Repos ~/.config ~/.local ~/ |
        ${pkgs.fzf}/bin/fzf --height=80% --border=rounded --margin=3%,3% \
          --padding=1 --delimiter=' | ')
    fi

    if [[ -z $directory ]]; then
      exit 0
    fi

    tab_name=$(basename "$directory" | tr . _)
    existing_tabs=$(${pkgs.kitty}/bin/kitty @ ls | ${pkgs.jq}/bin/jq -r '.[].tabs[] | "\(.title) \(.id)"')

    # Check if tab_name exists in existing_tabs
    if tab_info=$(echo "$existing_tabs" | grep "^$tab_name "); then
      # Tab exists, focus on it
      tab_id=$(echo "$tab_info" | awk '{print $NF}')
      ${pkgs.kitty}/bin/kitty @ focus-tab --match id:"$tab_id"
    else
      # Tab does not exist, create a new tab with the directory as cwd
      ${pkgs.kitty}/bin/kitty @ launch --type tab --tab-title "$tab_name" --cwd "$directory"
    fi
  '';
in
{
  home.packages = [ kitab ];
}
