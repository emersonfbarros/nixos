# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
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

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "rtsx_usb_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/505a5785-e016-45de-b60f-76b1656e575c";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "compress=zstd:1"
      "noatime"
      "ssd"
      "discard=async"
      "space_cache=v2"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4836-23F8";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/505a5785-e016-45de-b60f-76b1656e575c";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd:1"
      "noatime"
      "ssd"
      "discard=async"
      "space_cache=v2"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/505a5785-e016-45de-b60f-76b1656e575c";
    fsType = "btrfs";
    options = [
      "subvol=@nix"
      "compress=zstd:1"
      "noatime"
      "ssd"
      "discard=async"
      "space_cache=v2"
    ];
  };

  fileSystems."/tmp" = {
    device = "/dev/disk/by-uuid/505a5785-e016-45de-b60f-76b1656e575c";
    fsType = "btrfs";
    options = [
      "subvol=@tmp"
      "compress=zstd:1"
      "noatime"
      "ssd"
      "discard=async"
      "space_cache=v2"
    ];
  };

  fileSystems."/var/cache" = {
    device = "/dev/disk/by-uuid/505a5785-e016-45de-b60f-76b1656e575c";
    fsType = "btrfs";
    options = [
      "subvol=@cache"
      "compress=zstd:1"
      "noatime"
      "ssd"
      "discard=async"
      "space_cache=v2"
    ];
  };

  fileSystems."/var/lib/docker" = {
    device = "/dev/disk/by-uuid/505a5785-e016-45de-b60f-76b1656e575c";
    fsType = "btrfs";
    options = [
      "subvol=@docker"
      "compress=zstd:1"
      "noatime"
      "ssd"
      "discard=async"
      "space_cache=v2"
    ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/505a5785-e016-45de-b60f-76b1656e575c";
    fsType = "btrfs";
    options = [
      "subvol=@log"
      "compress=zstd:1"
      "noatime"
      "ssd"
      "discard=async"
      "space_cache=v2"
    ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
