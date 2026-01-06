{...}: let
in {
  # Nix
  system.stateVersion = "24.11";

  # Stop unneeded modules from loading
  boot.kernelParams = ["8250.nr_uarts=1"];
  boot.blacklistedKernelModules = ["serial8250"];

  boot.loader.timeout = 0;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-b2ecb7c8-f75e-4c01-adbc-b4ef8bdb79c1".device = "/dev/disk/by-uuid/b2ecb7c8-f75e-4c01-adbc-b4ef8bdb79c1";
  fileSystems = {
    "/mnt/nvme" = {
      device = "/dev/disk/by-uuid/01c6fcca-175e-4f8c-9335-9fcb085f930e";
      fsType = "ext4";
      options = ["nofail"];
    };

    "/mnt/media-drive" = {
      device = "/dev/disk/by-uuid/6ACEB562CEB526EB";
      fsType = "ntfs";
      options = ["nofail"];
    };
  };
}
