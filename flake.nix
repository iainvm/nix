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
          overlays = [inputs.nur.overlays.default];
        };
        "brokkr" = lib.mkNixosConfigurations {
          name = "brokkr";
          arch = "x86_64-linux";
          overlays = [inputs.nur.overlays.default];
        };
        "potamoi" = lib.mkNixosConfigurations {
          name = "potamoi";
          arch = "x86_64-linux";
          overlays = [inputs.nur.overlays.default];
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
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          overlays = [inputs.nur.overlays.default];
        };
        "iain@brokkr" = lib.mkHomeConfigurations {
          dir = "iain@brokkr";
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          overlays = [inputs.nur.overlays.default];
        };
        "river@brokkr" = lib.mkHomeConfigurations {
          dir = "river@brokkr";
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          overlays = [inputs.nur.overlays.default];
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
