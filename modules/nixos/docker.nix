{
  flake.modules.nixos.docker = {
    # Rootless Docker with btrfs storage
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
      storageDriver = "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
