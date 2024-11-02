{ pkgs, ... }:
{
  home.file.".config/nvim".source = "${builtins.getEnv "HOME"}/config.nvim";
  home.packages = with pkgs; [
    neovim

    # LSPs
    gopls
    taplo
    rust-analyzer
    clippy
    typescript-language-server
    lua-language-server
    bash-language-server
    pyright
    marksman
    omnisharp-roslyn
    dockerfile-language-server-nodejs
    docker-compose-language-service
    vscode-langservers-extracted

    # DAPs
    delve
    vscode-extensions.vadimcn.vscode-lldb
    vscode-js-debug

    # Linters
    golangci-lint
    buf
    biome
    eslint
    shellcheck
    markdownlint-cli

    # Formatters
    gofumpt
    goimports-reviser
    golines
    stylua
    nodePackages_latest.prettier
    shfmt
  ];
}
