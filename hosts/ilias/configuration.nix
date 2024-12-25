{ stateVersion, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
  ];

  # Define machine hostname (creative, don't you think?)
  networking.hostName = hostname;

  # Set time zone
  time.timeZone = "America/Maceio";

  # Forgive me, Stallman sensei
  nixpkgs.config.allowUnfree = true;

  # Don't change it bro
  system.stateVersion = stateVersion;

  # I use flakes btw
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
