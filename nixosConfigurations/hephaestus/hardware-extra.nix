{...}: let
in {
  # Nix
  system.stateVersion = "24.11";

  boot.loader.timeout = 0;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-aea74856-1276-49bb-9b6b-f8c8415566ac".device = "/dev/disk/by-uuid/aea74856-1276-49bb-9b6b-f8c8415566ac";
}