{ config, inputs, ... }:
{
  nixosHosts.regulus = {
    unstable = true;
  };

  flake.modules.nixos.host_regulus = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      inputs.stylix.nixosModules.stylix
      config.flake.modules.nixos.games
      config.flake.modules.nixos.workstation
    ];

    # Regulus specific
    environment.pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
    networking.hostName = "regulus";

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users.emerson = {
        imports = with config.flake.modules.homeManager; [
          # Core
          core
          session

          # Theming
          stylix

          # CLI tools
          cli-tools
          zsh
          starship
          git
          gpg
          ssh
          tmux-full

          # Desktop environment
          sway
          waybar
          tofi
          mako
          swaylock
          gammastep
          xdg

          # Apps
          kitty
          alacritty
          firefox
          mpv
          zathura
          yazi
          obsidian
          vscode
          htop
          nh
          utils

          # Custom scripts
          chmic
          chrb
          chspk
          extract
          kitab
          kiwindow
          selectfile
          tofi-power
          tofi-web-search
          v
          yt
          zt

          # Coding/development
          build
          langs
          neovim-config
        ];
      };
    };
  };
}
