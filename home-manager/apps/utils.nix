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
    zip
    xfce.thunar
    xfce.thunar-volman
    qalculate-gtk
    pavucontrol
    blueman
    gh
    xdg-utils
  ];

  services = {
    blueman-applet.enable = true;
  };
}
