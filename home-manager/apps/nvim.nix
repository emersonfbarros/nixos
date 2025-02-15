{ config, pkgs, ... }:
{
  home.file.".config/nvim/" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home-manager/apps/nvim";
    recursive = true;
  };
  home.packages = with pkgs; [
    neovim

    # LSPs
    bash-language-server
    docker-compose-language-service
    dockerfile-language-server-nodejs
    gopls
    lua-language-server
    marksman
    nixd
    pyright
    tailwindcss-language-server
    taplo
    vscode-langservers-extracted # eslint, html, jsonls, cssls
    vtsls

    # DAPs
    delve
    vscode-extensions.vadimcn.vscode-lldb.adapter
    vscode-js-debug

    # Linters
    biome
    buf
    golangci-lint
    golangci-lint-langserver
    shellcheck

    # Formatters
    gofumpt
    goimports-reviser
    golines
    nixfmt-rfc-style
    nodePackages_latest.prettier
    shfmt
    stylua

    # Required for copilot chat plugin
    lua51Packages.tiktoken_core

    neovim-node-client

    gomodifytags
    impl
    iferr
    statix
    checkmake
    go-tools
    commitlint
    editorconfig-checker
    hadolint
    govulncheck
  ];
}
