{ stateVersion, hostname, ... }:
{
  imports = [
    ../../nixos/modules
    ../../nixos/modules/games.nix
    ./hardware-configuration.nix
    ./local-packages.nix
  ];

  networking.hostName = hostname;

  # Don't change it bro
  system.stateVersion = stateVersion;
}
