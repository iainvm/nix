{nixpkgs, ...}: let
  computerName = "chronos";
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in
  nixpkgs.lib.nixosSystem {
    system = system;
    specialArgs = {inherit inputs;};

    modules = [
      self.nixosModules.default
      {
        system.stateVersion = "24.05";
        nix-flakes.enable = true;
        network = {
          enable = true;
          hostName = computerName;
        };
        
        # System Packages
        programs.zsh.enable = true;

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
