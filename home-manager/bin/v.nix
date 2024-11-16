{ pkgs, ... }:
let
  v = pkgs.writeShellScriptBin "v" ''
    if [ -n "$1" ]; then
      file=$1
    else
      file=$(selectfile)
    fi

    if [ -n "$file" ]; then
      ${pkgs.neovim}/bin/nvim "$file"
    fi
  '';
in
{
  home.packages = [ v ];
}
