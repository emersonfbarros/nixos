{ config, ... }:
{
  programs = {
    nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/.dotfiles";
    };
  };
}
