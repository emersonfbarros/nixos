{
  services = {
    fstrim.enable = true;

    gnome.gnome-keyring.enable = true;

    upower.enable = true;

    gvfs.enable = true;

    seatd.enable = true;
  };

  # Idk, swaylock needs it to work
  security = {
    polkit.enable = true;
    pam.services.swaylock = { };
  };

  programs.dconf.enable = true;
}
