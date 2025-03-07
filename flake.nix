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
      url = "github:0xc000022070/zen-browser-flake";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions/1fc267a10f46200e32f0850caa396bd1ba4ba08e";
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
          arch = "x86_64-linux";
        };
        "brokkr" = lib.mkNixosConfigurations {
          name = "brokkr";
          arch = "x86_64-linux";
        };
        "potamoi" = lib.mkNixosConfigurations {
          name = "potamoi";
          arch = "x86_64-linux";
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
          arch = "x86_64-linux";
        };
        "iain@brokkr" = lib.mkHomeConfigurations {
          dir = "iain@brokkr";
          arch = "x86_64-linux";
        };
        "river@brokkr" = lib.mkHomeConfigurations {
          dir = "river@brokkr";
          arch = "x86_64-linux";
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
