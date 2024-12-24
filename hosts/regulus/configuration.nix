{ stateVersion, hostname, ... }:
{
  imports = [
    # Include the results of the hardware scan and my modules
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
    ../../nixos/modules/games.nix
  ];

  # Define machine hostname (creative, don't you think?)
  networking.hostName = hostname;

  # Set time zone
  time.timeZone = "America/Maceio";

  # Forgive me, Stallman sensei
  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Don't change it bro
  system.stateVersion = stateVersion;

  # I use flakes btw
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
