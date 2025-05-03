{
  system,
  nixpkgs,
  ...
}: let
  computerName = "chronos";
  pkgs = import nixpkgs {inherit system;};
in {
  # Nix
  system.stateVersion = "24.11";

  boot.loader.timeout = 0;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-b2ecb7c8-f75e-4c01-adbc-b4ef8bdb79c1".device = "/dev/disk/by-uuid/b2ecb7c8-f75e-4c01-adbc-b4ef8bdb79c1";
  fileSystems = {
    "/mnt/nvme" = {
      device = "/dev/disk/by-uuid/01c6fcca-175e-4f8c-9335-9fcb085f930e";
      fsType = "ext4";
    };

    "/mnt/media-drive" = {
      device = "/dev/disk/by-uuid/6ACEB562CEB526EB";
      fsType = "ntfs";
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  core = {
    nix.flakes.enable = true;
    display-manager.sddm.enable = true;

    # Hardware
    hardware = {
      network = {
        enable = true;
        hostName = computerName;
      };
      sound.enable = true;
      nvidia.enable = true;
      bluetooth.enable = true;
    };

    # System
    system = {
      language.en-gb.enable = true;
      plymouth = {
        enable = true;
        silent-boot = true;
      };

      # Session Manager
      keyring.enable = true;
      # Window Manager
      hyprland.enable = true;
    };

    # Applications
    applications = {
      steam.enable = true; # Has to be installed system wide for openGL
      thunar.enable = true;
    };

    # System Packages
    zsh.enable = true;

    # Users
    users = {
      users = {
        iain = {
          host = computerName;
          group = "iain";
          shell = pkgs.zsh;
          extraGroups = ["networkmanager" "wheel"];
        };
      };
    };
  };
}
