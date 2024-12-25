{ stateVersion, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
  ];

  networking.hostName = hostname;

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
