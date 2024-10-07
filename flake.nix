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

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    # vscode-server = {
    #   url = "github:nix-community/nixos-vscode-server";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    {
      # Systems
      nixosConfigurations = {
        # Potamoi
        potamoi = import ./systems/potamoi/configuration.nix {
          inherit self inputs nixpkgs;
        };
      };

      nixosModules = {
        default = import ./nixosModules/default.nix;
      };
    }
    # Dev Shell for updating the flake
    // flake-utils.lib.eachDefaultSystem (system: {
      devShells = import ./dev/shell.nix {
        inherit system nixpkgs;
      };
    });
}
