{nixpkgs, ...}: let
  computerName = "chronos";
  pkgs = nixpkgs.legacyPackages."x86_64-linux";
in {
  # Nix
  system.stateVersion = "24.11";

  services.flatpak = {
    enable = true;
  };

  imports = [
    ./hardware-extra.nix
  ];

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  hardware.keyboard.zsa.enable = true;

  core = {
    nix.flakes.enable = true;
    display-manager.sddm = {
      enable = true;
      disabled-displays = ["HDMI-A-2"];
    };

    # Hardware
    hardware = {
      network = {
        enable = true;
        hostName = computerName;
      };
      sound = {
        enable = true;
        noisetorch = {
          enable = true;
          device-unit = ''sys-devices-pci0000:00-0000:00:08.3-0000:11:00.0-usb7-7\x2d1-7\x2d1.3-7\x2d1.3:1.0-sound-card3-controlC3.device'';
          device-id = "alsa_input.usb-SteelSeries_Arctis_Nova_Pro_Wireless-00.mono-fallback";
        };
      };
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
      _1password = {
        enable = true;
        users = ["iain"];
      };
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
