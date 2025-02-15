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
let
  subvolOptions = [
    "compress=zstd:1"
    "noatime"
    "ssd"
    "discard=async"
    "space_cache=v2"
  ];
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/456af7a2-73fb-473f-b512-ccf1aa424504";
    fsType = "btrfs";
    options = [ "subvol=@" ] ++ subvolOptions;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/456af7a2-73fb-473f-b512-ccf1aa424504";
    fsType = "btrfs";
    options = [ "subvol=@nix" ] ++ subvolOptions;
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/456af7a2-73fb-473f-b512-ccf1aa424504";
    fsType = "btrfs";
    options = [ "subvol=@log" ] ++ subvolOptions;
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/456af7a2-73fb-473f-b512-ccf1aa424504";
    fsType = "btrfs";
    options = [ "subvol=@home" ] ++ subvolOptions;
  };

  fileSystems."/tmp" = {
    device = "/dev/disk/by-uuid/456af7a2-73fb-473f-b512-ccf1aa424504";
    fsType = "btrfs";
    options = [ "subvol=@tmp" ] ++ subvolOptions;
  };

  fileSystems."/var/cache" = {
    device = "/dev/disk/by-uuid/456af7a2-73fb-473f-b512-ccf1aa424504";
    fsType = "btrfs";
    options = [ "subvol=@cache" ] ++ subvolOptions;
  };

  fileSystems."/var/lib/docker" = {
    device = "/dev/disk/by-uuid/456af7a2-73fb-473f-b512-ccf1aa424504";
    fsType = "btrfs";
    options = [ "subvol=@docker" ] ++ subvolOptions;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/629F-22A5";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
