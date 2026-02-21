{ config, lib, ... }:
{
  nixosHosts.ilias = {
    unstable = false;
  };

  flake.modules.nixos.host_ilias = {
    imports = with config.flake.modules.nixos; [
      graphics
      media-server
      neovim-minimal
      pihole
      podman
      sound
      ssh
    ];

    # Override core locale settings to use US layout
    services.xserver.xkb.layout = lib.mkForce "us";
    console.keyMap = lib.mkForce "us";
  };
}
