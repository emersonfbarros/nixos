{ config, ... }:
{
  flake.modules.nixos.workstation.imports = with config.flake.modules.nixos; [
    bluetooth
    docker
    graphics
    sound
    system-services
  ];
}
