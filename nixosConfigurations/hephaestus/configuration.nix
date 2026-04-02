{nixpkgs, ...}: let
  computerName = "hephaestus";
  pkgs = nixpkgs.legacyPackages."x86_64-linux";
in {
  # Nix
  system.stateVersion = "24.11";

  imports = [
    ./hardware-extra.nix
  ];

  hardware.keyboard.zsa.enable = true;

  core = {
    nix.flakes.enable = true;
    display-manager.ly.enable = true;

    # Hardware
    hardware = {
      network = {
        enable = true;
        hostName = computerName;
      };
      sound = {
        enable = true;
        #noisetorch = {
        #  enable = true;
        #  device-unit = ''sys-devices-pci0000:00-0000:00:1c.0-0000:02:00.0-0000:03:04.0-0000:39:00.0-0000:3a:00.0-0000:3b:00.0-usb5-5\x2d1-5\x2d1.1-5\x2d1.1.2-5\x2d1.1.2:1.0-sound-card1-controlC1.device'';
        #  device-id = "alsa_input.usb-SteelSeries_Arctis_Nova_7-00.mono-fallback";
        #};
      };
      bluetooth.enable = true;
      thunderbolt.enable = true;
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
        users = ["iain" "river"];
      };
      fwupd.enable = true;
      global-protect-vpn.enable = true;
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
      users = {
        river = {
          host = computerName;
          group = "river";
          shell = pkgs.zsh;
          extraGroups = ["networkmanager" "wheel"];
        };
      };
    };
  };
}
