{ pkgs, ... }:
{
  home.packages = with pkgs; [
    acpi
    blueman
    docker-compose
    gh
    google-chrome
    grim
    jq
    libnotify
    networkmanagerapplet
    pavucontrol
    playerctl
    qalculate-gtk
    slurp
    spotify
    swappy
    xdg-utils
    xfce.thunar
    xfce.thunar-volman
    yt-dlp
    zip
  ];

  services.blueman-applet.enable = true;
}
