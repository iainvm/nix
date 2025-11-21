{
  system,
  nixpkgs,
  ...
}: let
  computerName = "brokkr";
  pkgs = import nixpkgs {inherit system;};
in {
  # Nix
  system.stateVersion = "24.11";

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
      sound.enable = true;
      nvidia.enable = false;
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
          host = "brokkr";
          group = "iain";
          shell = pkgs.zsh;
          extraGroups = ["networkmanager" "wheel"];
        };
      };
      users = {
        river = {
          host = "brokkr";
          group = "river";
          shell = pkgs.zsh;
          extraGroups = ["networkmanager" "wheel"];
        };
      };
    };
  };
}
