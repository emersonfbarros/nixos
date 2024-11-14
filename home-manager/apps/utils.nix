{ pkgs, ... }:
{
  home.packages = with pkgs; [
    acpi
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
    networkmanagerapplet
  ];

  services = {
    blueman-applet.enable = true;
  };
}
