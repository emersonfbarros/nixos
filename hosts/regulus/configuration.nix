{ stateVersion, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
    ../../nixos/modules/games.nix
  ];

  networking.hostName = hostname;

  # Don't change it bro
  system.stateVersion = stateVersion;
}
