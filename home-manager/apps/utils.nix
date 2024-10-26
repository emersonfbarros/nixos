{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jq
    libnotify
    fastfetch
    docker-compose
    firefox
    grim
    slurp
    swappy
    playerctl
    neovim
    zip
    xfce.thunar
    xfce.thunar-volman
    qalculate-gtk
    pavucontrol
    blueman
    gh
  ];

  services = {
    blueman-applet.enable = true;
  };
}
