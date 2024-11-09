{ config, pkgs, ... }:
{
  home.file."./.config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "/home/emerson/.dotfiles/home-manager/apps/nvim";
  home.packages = with pkgs; [
    neovim

    # LSPs
    gopls
    taplo
    rust-analyzer
    typescript-language-server
    lua-language-server
    bash-language-server
    pyright
    marksman
    omnisharp-roslyn
    dockerfile-language-server-nodejs
    docker-compose-language-service
    vscode-langservers-extracted
    nixd

    # DAPs
    delve
    vscode-extensions.vadimcn.vscode-lldb.adapter
    vscode-js-debug

    # Linters
    golangci-lint
    clippy
    buf
    biome
    eslint
    shellcheck
    markdownlint-cli

    # Formatters
    gofumpt
    goimports-reviser
    golines
    rustfmt
    stylua
    nodePackages_latest.prettier
    shfmt
    nixfmt-rfc-style
  ];
}
