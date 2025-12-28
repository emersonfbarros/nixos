{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        eamodio.gitlens
        golang.go
        rust-lang.rust-analyzer
        usernamehw.errorlens
        vadimcn.vscode-lldb
        vscodevim.vim
      ];
    };
  };
}
