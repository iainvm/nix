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
