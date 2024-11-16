{ pkgs, ... }:
let
  extract = pkgs.writeShellScriptBin "extract" ''
    if [ -f "$1" ]; then
      case $1 in
      *.tar.bz2) ${pkgs.gnutar}/bin/tar xjf "$1" ;;
      *.tar.gz) ${pkgs.gnutar}/bin/tar xzf "$1" ;;
      *.bz2) ${pkgs.bzip2}/bin/bunzip2 "$1" ;;
      *.rar) ${pkgs.rar}/bin/rar x "$1" ;;
      *.gz) ${pkgs.gzip}/bin/gunzip "$1" ;;
      *.tar) ${pkgs.gnutar}/bin/tar xf "$1" ;;
      *.tbz2) ${pkgs.gnutar}/bin/tar xjf "$1" ;;
      *.tgz) ${pkgs.gnutar}/bin/tar xzf "$1" ;;
      *.zip) ${pkgs.unzip}/bin/unzip "$1" ;;
      *.Z) ${pkgs.gzip}/bin/uncompress "$1" ;;
      *.7z) ${pkgs.p7zip}/bin/7z x "$1" ;;
      *) echo "'$1' cannot be extracted via extract script" ;;
      esac
    else
      echo "'$1' is not a valid file"
    fi
  '';
in
{
  home.packages = [ extract ];
}
