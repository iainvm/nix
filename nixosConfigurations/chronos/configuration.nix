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
