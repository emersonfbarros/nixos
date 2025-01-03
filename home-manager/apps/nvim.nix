{ config, pkgs, ... }:
{
  home.file.".config/nvim/" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home-manager/apps/nvim";
    recursive = true;
  };
  home.packages = with pkgs; [
    neovim

    # LSPs
    gopls
    taplo
    rust-analyzer
    vtsls
    lua-language-server
    bash-language-server
    pyright
    marksman
    # omnisharp-roslyn
    dockerfile-language-server-nodejs
    docker-compose-language-service
    vscode-langservers-extracted # eslint, html, jsonls, cssls
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
    shellcheck
    markdownlint-cli2

    # Formatters
    gofumpt
    goimports-reviser
    golines
    rustfmt
    stylua
    nodePackages_latest.prettier
    shfmt
    nixfmt-rfc-style

    # Required for copilot chat plugin
    lua51Packages.tiktoken_core
  ];
}
