{ pkgs, ... }:
{
  home.packages = with pkgs; [
    acpi
    jq
    libnotify
    docker-compose
    grim
    slurp
    grim
    google-chrome
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
    mpv
    spotify
    yt-dlp
    networkmanagerapplet
    zathura
  ];

  services = {
    blueman-applet.enable = true;
  };
}
