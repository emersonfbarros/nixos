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
    grim
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
    zathura
  ];

  services = {
    blueman-applet.enable = true;
  };
}
