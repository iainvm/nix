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
    specialArgs = {inherit inputs;};

    modules = [
      inputs.nixos-wsl.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.default
      {
        wsl.enable = true;
        nix-flakes.enable = true;
        networking.hostName = "potamoi";
        system.stateVersion = "24.05";

        programs.zsh.enable = true;

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

        environment.systemPackages = with pkgs; [
          git
        ];
      }
    ];
  }
