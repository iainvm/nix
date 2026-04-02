{
  description = "My Nix configs";

  # Dependencies
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
  # Dev Shell for updating the flake
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg:
          builtins.elem (pkgs.lib.getName pkg) [
            "terraform"
          ];
      };
    in {
      devShells = {
        default = pkgs.mkShell {
          shellHook = ''
            export AWS_VAULT_BACKEND=pass
            export GOPRIVATE="github.com/River-Island"
            export GONOPROXY="github.com/River-Island"
          '';

          # Required for debugging Go
          hardeningDisable = ["fortify"];

          packages = with pkgs; [
            # Tools for editing nix flake
            alejandra

            # AWS
            awscli
            aws-vault

            # Tools
            git
            gnumake
            go-task

            # Go
            go
            delve
            golangci-lint
            gopls
            mockgen
            gofumpt

            # Python
            python3

            # Terraform
            terraform
            terragrunt
          ];
        };
      };
    });
}
