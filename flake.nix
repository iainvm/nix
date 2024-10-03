{
  description = "My Nix configs";

  # Dependencies
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-wsl,
    flake-utils,
    ...
  } @ inputs:
    {
      # Systems
      nixosConfigurations = {
        # Potamoi
        potamoi = import ./systems/potamoi/configuration.nix {
          inherit self nixpkgs nixos-wsl;
        };
      };

      nixosModules = builtins.listToAttrs (map (name: {
        name = nixpkgs.lib.strings.removeSuffix ".nix" name;
        value = import (./nixosModules + "/${name}");
      }) (builtins.attrNames (builtins.readDir ./nixosModules)));
    }
    # Dev Shell for updating the flake
    // flake-utils.lib.eachDefaultSystem (system: {
      devShells = import ./dev/shell.nix {
        inherit system nixpkgs;
      };
    });
}
