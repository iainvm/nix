{
  self,
  inputs,
  nixpkgs,
  ...
}: let
  computerName = "potamoi";
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in
  nixpkgs.lib.nixosSystem {
    system = system;
    specialArgs = {inherit inputs;};

    modules = [
      inputs.nixos-wsl.nixosModules.default
      self.nixosModules.default
      {
        # Nix
        system.stateVersion = "24.05";
        nix-flakes.enable = true;

        # System
        boot.kernelModules = [];
        wsl = {
          enable = true;
          extraBin = [
            {src = nixpkgs.lib.getExe' pkgs.coreutils "dirname";}
            {src = nixpkgs.lib.getExe' pkgs.coreutils "readlink";}
            {src = nixpkgs.lib.getExe' pkgs.coreutils "uname";}
          ];
        };
        en-gb.enable = true;
        network = {
          enable = true;
          hostName = computerName;
        };

        # System Packages
        fish.enable = true;
        vscode-server.enable = true;

        # Users
        wsl.defaultUser = "iain";
        simple-users = {
          users = {
            iain = {
              group = "iain";
              extraGroups = ["wheel"];
              shell = pkgs.fish;
              home-manager = ./users/iain/configuration.nix;
            };
          };
        };
      }
    ];
  }
