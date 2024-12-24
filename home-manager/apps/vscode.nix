{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;

    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      golang.go
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
      eamodio.gitlens
      usernamehw.errorlens
    ];
  };
}
