{
  # enable docker
  # use docker without Root access (Rootless docker)
  virtualisation.docker = {
    enable = true;

    enableOnBoot = false;
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
