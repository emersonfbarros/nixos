{ config, inputs, ... }:
{
  flake.modules.nixos.core = _: {
    imports = with config.flake.modules.nixos; [
      inputs.disko.nixosModules.disko
      base-policy
      users
      packages
      bootloader
      garbage-collector
      locale
      network
      swap
      nix-index
    ];

    # Basic system settings common to all machines
    system.stateVersion = "25.11";
  };
}
