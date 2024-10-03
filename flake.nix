{
  # github.com/iainvm/nix
  description = "My Nix config";

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

  outputs = {self, nixpkgs, nixos-wsl, flake-utils, ...}:
  {
    # Dev Shell for updating nix configs
    flake-utils.lib.eachDefaultSystem (system: {
        devShell = import ./devShell.nix {inherit nixpkgs;};
    });
  };
}
