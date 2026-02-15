{ config, lib, ... }:
{
  nixosHosts.ilias = {
    unstable = false;
  };

  # Server gets NixOS core (packages.nix includes tmux)
  # No additional config needed - default tmux settings are fine for server
  flake.modules.nixos.host_ilias = {
    imports = with config.flake.modules.nixos; [
      podman
      neovim-minimal
      ssh
    ];

    # Override core locale settings to use US layout
    services.xserver.xkb.layout = lib.mkForce "us";
    console.keyMap = lib.mkForce "us";
  };
}
