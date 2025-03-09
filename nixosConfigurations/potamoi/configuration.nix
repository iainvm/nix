{
  self,
  system,
  inputs,
  nixpkgs,
  ...
}: let
  computerName = "potamoi";
  pkgs = import nixpkgs {inherit system;};
in
  nixpkgs.lib.nixosSystem {
    inherit pkgs;
    system = system;
    specialArgs = {inherit inputs;};

    modules = [
      inputs.nixos-wsl.nixosModules.default
      self.nixosModules.default
      {
        # Nix
        system.stateVersion = "24.05";

        # System
        wsl = {
          defaultUser = "iain";
          enable = true;
          extraBin = [
            {src = inputs.nixpkgs.lib.getExe' pkgs.coreutils "dirname";}
            {src = inputs.nixpkgs.lib.getExe' pkgs.coreutils "readlink";}
            {src = inputs.nixpkgs.lib.getExe' pkgs.coreutils "uname";}
          ];
        };

        core = {
          nix.flakes.enable = true;

          hardware = {
            network = {
              enable = true;
              hostName = computerName;
            };
          };

          system = {
            language.en-gb.enable = true;
            keyring.enable = true;
          };

          applications = {
            vscode-server.enable = true;
          };

          # System Packages
          zsh.enable = true;

          users = {
            users = {
              iain = {
                host = "potamoi";
                group = "iain";
                extraGroups = ["wheel"];
                shell = pkgs.zsh;
              };
            };
          };
        };
      }
    ];
  }
