{ pkgs, ... }:
let
  selectFile = pkgs.writeShellScriptBin "selectfile" ''
    ${pkgs.fd}/bin/fd -tf -H --exclude .git --exclude node_modules | \
      ${pkgs.fzf}/bin/fzf --tmux 80% \
      --preview 'bat --color=always --style=header,grid --line-range :500 {}' \
      --preview-window=right,65%
  '';
in
{
  home.packages = [ selectFile ];
}
