{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;

    extensions = with pkgs; [
      vscode-extensions.vscodevim.vim
      vscode-extensions.golang.go
      vscode-extensions.rust-lang.rust-analyzer
      vscode-extensions.vadimcn.vscode-lldb
      vscode-extensions.eamodio.gitlens
      vscode-extensions.usernamehw.errorlens
    ];
  };
}
