{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f9ee3043-f40d-4465-89e9-5b371a92491f";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-c0a57004-a2fe-4336-8035-401e86a5ee32".device = "/dev/disk/by-uuid/c0a57004-a2fe-4336-8035-401e86a5ee32";

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/7549-FE2D";
      fsType = "vfat";
    };

    "/mnt/nvme" = {
      device = "/dev/disk/by-uuid/01c6fcca-175e-4f8c-9335-9fcb085f930e";
      fsType = "ext4";
    };

    "/mnt/media-drive" = {
      device = "/dev/disk/by-uuid/6ACEB562CEB526EB";
      fsType = "ntfs";
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/6dcbb9de-7238-4498-bfc7-a69e29639f20";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp11s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp12s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Bootloader
  boot.loader.timeout = 0;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-f4ee2e33-ec68-48ca-a6c0-d1b61c075cca".device = "/dev/disk/by-uuid/f4ee2e33-ec68-48ca-a6c0-d1b61c075cca";
}
