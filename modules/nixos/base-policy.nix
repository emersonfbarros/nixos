{
  flake.modules.nixos.base-policy = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
