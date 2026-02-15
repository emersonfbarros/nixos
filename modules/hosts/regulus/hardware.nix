{
  flake.modules.nixos.host_regulus =
    {
      config,
      lib,
      modulesPath,
      pkgs,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot = {
        # Use latest linux kernel
        kernelPackages = pkgs.linuxPackages_latest;

        initrd = {
          availableKernelModules = [
            "ahci"
            "nvme"
            "usbhid"
            "xhci_pci"
          ];
          kernelModules = [ ];
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      networking.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

  # Only for tests inside VM
  # {
  #   imports = [
  #     (modulesPath + "/profiles/qemu-guest.nix")
  #   ];
  #
  #   boot = {
  #     # Use latest linux kernel
  #     kernelPackages = pkgs.linuxPackages_latest;
  #
  #     initrd = {
  #       availableKernelModules = [
  #         "ahci"
  #         "sr_mod"
  #         "virtio_blk"
  #         "virtio_pci"
  #         "xhci_pci"
  #       ];
  #       kernelModules = [ ];
  #     };
  #     kernelModules = [ "kvm-intel" ];
  #     extraModulePackages = [ ];
  #   };
  #
  #   nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # };
}
