{
  description = "My Nix configs";

  # Dependencies
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    ...
  } @ inputs: let
    lib = import ./lib {inherit self inputs nixpkgs;};
  in
    {
      # Systems
      nixosConfigurations = {
        "chronos" = lib.mkNixosConfigurations {
          name = "chronos";
          system = "x86_64-linux";
        };
        "brokkr" = lib.mkNixosConfigurations {
          name = "brokkr";
          system = "x86_64-linux";
        };
        "potamoi" = lib.mkNixosConfigurations {
          name = "potamoi";
          system = "x86_64-linux";
        };
      };

      # NixOS Modules
      nixosModules = {
        default = import ./nixosModules/default.nix;
      };

      # Home Configurations
      homeConfigurations = {
        "iain@chronos" = lib.mkHomeConfigurations {
          dir = "iain@chronos";
          system = "x86_64-linux";
        };
        "iain@brokkr" = lib.mkHomeConfigurations {
          dir = "iain@brokkr";
          system = "x86_64-linux";
        };
        "river@brokkr" = lib.mkHomeConfigurations {
          dir = "river@brokkr";
          system = "x86_64-linux";
        };
      };

      # Home Manager Modules
      homeModules = {
        default = import ./homeModules/default.nix;
      };
    }
    # Dev Shell for updating the flake
    // flake-utils.lib.eachDefaultSystem (system: {
      devShells = import ./devShells/configuration.nix {
        inherit inputs system;
      };
    });
}
