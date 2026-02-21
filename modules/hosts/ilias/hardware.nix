{
  flake.modules.nixos.host_ilias =
    {
      config,
      lib,
      pkgs,
      modulesPath,
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
            "sd_mod"
            "sdhci_pci"
            "usb_storage"
            "usbhid"
            "xhci_pci"
          ];
          kernelModules = [ ];
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];

        blacklistedKernelModules = [
          "rtw88_8822c"
          "rtw88_8822ce"
          "rtw88_core"
          "rtw88_pci"
        ];

        kernelParams = [ "pcie_aspm=off" ];
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
