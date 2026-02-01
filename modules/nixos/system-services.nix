{
  flake.modules.nixos.system-services = {
    services = {
      fstrim.enable = true;
      gnome.gnome-keyring.enable = true;
      upower.enable = true;
      gvfs.enable = true;
      seatd.enable = true;
    };

    # Swaylock needs polkit and PAM
    security = {
      polkit.enable = true;
      pam.services.swaylock = { };
    };

    programs.dconf.enable = true;
  };
}
