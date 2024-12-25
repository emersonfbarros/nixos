{ stateVersion, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
  ];

  networking.hostName = hostname;

  # Don't change it bro
  system.stateVersion = stateVersion;
}
