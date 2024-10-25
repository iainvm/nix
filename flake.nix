{
  description = "My Nix configs";

  # Dependencies
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    flake-utils,
    ...
  } @ inputs:
    {
      # Systems
      nixosConfigurations = {
        # Chronos
        chronos = import ./nixosConfigurations/chronos/configuration.nix {
          inherit self inputs nixpkgs nixpkgs-unstable;
        };
        # Potamoi
        potamoi = import ./nixosConfigurations/potamoi/configuration.nix {
          inherit self inputs nixpkgs nixpkgs-unstable;
        };
      };

      # NixOS Modules
      nixosModules = {
        default = import ./nixosModules/default.nix;
      };

      # Home Manager Modules
      homeManagerModules = {
        default = import ./homeManagerModules/default.nix;
      };
    }
    # Dev Shell for updating the flake
    // flake-utils.lib.eachDefaultSystem (system: {
      devShells = import ./devShells/configuration.nix {
        inherit inputs system;
      };
    });
}
