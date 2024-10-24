{
  self,
  inputs,
  ...
}: let
  computerName = "potamoi";
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    # overlays = [
    #   (final: prev: {
    #     unstable = import inputs.nixpkgs-unstable {
    #       inherit system;
    #       config = {
    #         allowUnfree = true;
    #       };
    #     };
    #   })
    # ];
  };
in
  inputs.nixpkgs.lib.nixosSystem {
    system = system;
    specialArgs = {inherit inputs;};

    modules = [
      inputs.nixos-wsl.nixosModules.default
      self.nixosModules.default
      {
        # Nix
        system.stateVersion = "24.05";
        nix-flakes.enable = true;

        # System
        boot.kernelModules = [];
        wsl = {
          enable = true;
          extraBin = [
            {src = inputs.nixpkgs.lib.getExe' pkgs.coreutils "dirname";}
            {src = inputs.nixpkgs.lib.getExe' pkgs.coreutils "readlink";}
            {src = inputs.nixpkgs.lib.getExe' pkgs.coreutils "uname";}
          ];
        };
        en-gb.enable = true;
        network = {
          enable = true;
          hostName = computerName;
        };

        # System Packages
        zsh.enable = true;
        vscode-server.enable = true;

        # Users
        wsl.defaultUser = "iain";
        simple-users = {
          users = {
            iain = {
              group = "iain";
              extraGroups = ["wheel"];
              shell = pkgs.zsh;
              home-manager = ./users/iain/configuration.nix;
            };
          };
        };
      }
    ];
  }
