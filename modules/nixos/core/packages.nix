# System-wide packages for all NixOS hosts (including servers)
{
  flake.modules.nixos.packages =
    { pkgs, ... }:
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
        htop
      ];

      # Basic neovim for editing on all hosts
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };
    };
}
