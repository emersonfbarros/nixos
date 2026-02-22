# System-wide packages for all NixOS hosts (including servers)
{
  flake.modules.nixos.packages =
    { config, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Core CLI tools
        fd
        git
        ripgrep
        tmux
        tree

        # File management
        unzip
        wget
        zip

        # System monitoring
        btop
      ];

      # Basic neovim for editing on all hosts
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };

      # System-wide aliases available to all shells (bash, zsh) on all hosts
      environment.shellAliases = {
        rebuild = ''sudo nixos-rebuild switch --flake "$HOME/.dotfiles#${config.networking.hostName}"'';
      };
    };
}
