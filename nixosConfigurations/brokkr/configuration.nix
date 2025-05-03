{
  system,
  nixpkgs,
  ...
}: let
  computerName = "brokkr";
  pkgs = import nixpkgs {inherit system;};
in {
  environment.systemPackages = with pkgs; [
    home-manager
  ];
  # Flatpak
  services.flatpak.enable = true;

  # Nix
  system.stateVersion = "24.11";

  core = {
    nix.flakes.enable = true;
    display-manager.cosmic-greeter.enable = true;

    # Hardware
    hardware = {
      network = {
        enable = true;
        hostName = computerName;
      };
      sound.enable = true;
      nvidia.enable = true;
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
