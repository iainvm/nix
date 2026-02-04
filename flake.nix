{
  description = "My Nix configs";

  # Dependencies
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    dpm = {
      url = "github:iainvm/dpm";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
    };

    stylix = {
      url = "github:danth/stylix";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs: let
    lib = import ./lib {inherit self inputs nixpkgs;};
  in
    {
      # NixOs Configurations
      nixosConfigurations = {
        "chronos" = lib.mkNixosConfigurations {
          name = "chronos";
        };
        "brokkr" = lib.mkNixosConfigurations {
          name = "brokkr";
          modules = [
            inputs.nixos-hardware.nixosModules.dell-xps-15-9500-nvidia
          ];
        };
      };

      # NixOS Modules
      nixosModules = {
        default = import ./nixosModules/default.nix;
      };

      # Home Configurations
      homeConfigurations = {
        "iain@chronos" = self.nixosConfigurations.chronos.config.home-manager.users.iain.home;

        "river@brokkr" = self.nixosConfigurations.brokkr.config.home-manager.users.river.home;
        "iain@brokkr" = self.nixosConfigurations.brokkr.config.home-manager.users.iain.home;
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
