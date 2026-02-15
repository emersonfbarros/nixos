{
  flake.modules.homeManager.utils =
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
        swappy
        xdg-utils
        thunar
        thunar-volman
        yt-dlp
        zip
      ];

      services.blueman-applet.enable = true;
    };
}
