# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];

  boot.extraModulePackages = [ ];

  fileSystems."/mnt/External" = {
    device = "/dev/disk/by-label/External";
    fsType = "exfat";
    options = [ "nofail" "uid=1000" "gid=100" ];
  };

  fileSystems."/mnt/Library" = {
    device = "/dev/disk/by-label/Library";
    fsType = "ext4";
    options = [ "nofail" ];
  };
  fileSystems."/mnt/FastMedia" = {
    device = "/dev/disk/by-label/FastMedia";
    fsType = "ext4";
    options = [ "nofail" ];
  };
  fileSystems."/mnt/Media" = {
    device = "/dev/disk/by-label/Media";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
