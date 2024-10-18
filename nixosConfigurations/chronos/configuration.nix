{
  self,
  inputs,
  nixpkgs,
  ...
}: let
  computerName = "chronos";
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in
  nixpkgs.lib.nixosSystem {
    system = system;
    specialArgs = {inherit inputs nixpkgs system;};

    modules = [
      ./hardware-configuration.nix
      self.nixosModules.default
      {
        # Nix
        system.stateVersion = "24.05";
        nix-flakes.enable = true;

        # System
        plymouth.enable = true;
        en-gb.enable = true;
        nvidia.enable = true;
        bluetooth.enable = true;
        network = {
          enable = true;
          hostName = computerName;
        };

        # Environment
        sddm.enable = true;
        hyprland.enable = true;

        # System Packages
        fish.enable = true;

        # Users
        simple-users = {
          users = {
            iain = {
              group = "iain";
              extraGroups = ["wheel"];
              shell = pkgs.zsh;
              home-manager = ./users/iain/configuration.nix;
            };
          };
        };
      }
    ];
  }
