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
    lib = import ./lib {inherit inputs;};
  in
    {
      # Systems
      nixosConfigurations = {
        # Chronos
        chronos = import ./nixosConfigurations/chronos/configuration.nix {
          inherit self inputs nixpkgs;
        };
        # Brokkr
        brokkr = import ./nixosConfigurations/brokkr/configuration.nix {
          inherit self inputs nixpkgs;
        };
        # Potamoi
        potamoi = import ./nixosConfigurations/potamoi/configuration.nix {
          inherit self inputs nixpkgs;
        };
      };

      # NixOS Modules
      nixosModules = {
        default = import ./nixosModules/default.nix;
      };

      # Home Configurations
      homeConfigurations = {
        iain = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;

          extraSpecialArgs = { inherit self inputs nixpkgs; };
          modules = [
            { nixpkgs.config.allowUnfree = true; }
            {nixpkgs.overlays = [inputs.nur.overlays.default];}
            ./homeConfigurations/iain/home.nix
          ];
        };
        iain-brokkr = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;

          extraSpecialArgs = { inherit self inputs nixpkgs; };
          modules = [
            { nixpkgs.config.allowUnfree = true; }
            {nixpkgs.overlays = [inputs.nur.overlays.default];}
            ./homeConfigurations/iain-brokkr/home.nix
          ];
        };
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
