{
  self,
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  ...
}: let
  computerName = "potamoi";
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      })
    ];
  };
in
  nixpkgs.lib.nixosSystem {
    inherit pkgs;
    system = system;
    specialArgs = {inherit inputs;};

    modules = [
      inputs.nixos-wsl.nixosModules.default
      self.nixosModules.default
      {
        # Nix
        system.stateVersion = "24.05";

        # System
        wsl = {
          defaultUser = "iain";
          enable = true;
          extraBin = [
            {src = inputs.nixpkgs.lib.getExe' pkgs.coreutils "dirname";}
            {src = inputs.nixpkgs.lib.getExe' pkgs.coreutils "readlink";}
            {src = inputs.nixpkgs.lib.getExe' pkgs.coreutils "uname";}
          ];
        };

        core = {
          nix.flakes.enable = true;

          hardware = {
            network = {
              enable = true;
              hostName = computerName;
            };
          };

          system = {
            language.en-gb.enable = true;
            keyring.enable = true;
          };

          applications = {
            vscode-server.enable = true;
          };

          # System Packages
          zsh.enable = true;

          users = {
            users = {
              iain = {
                group = "iain";
                extraGroups = ["wheel"];
                shell = pkgs.zsh;
                home-manager = ./users/iain/configuration.nix;
              };
            };
          };
        };
      }
    ];
  }
