{
  self,
  inputs,
  nixpkgs,
  ...
}: let
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in
  nixpkgs.lib.nixosSystem {
    system = system;

    modules = [
      inputs.nixos-wsl.nixosModules.default
      self.nixosModules.default
      {
        wsl.enable = true;
        nix-flakes.enable = true;
        networking.hostName = "potamoi";
        system.stateVersion = "24.05";

        # Users
        simple-users = {
          users = {
            iain = {
              group = "iain";
            };
          };
        };

        environment.systemPackages = with pkgs; [
          git
        ];
      }
    ];
  }
