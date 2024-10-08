{nixpkgs, ...}: let
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in
  nixpkgs.lib.nixosSystem {
    system = system;

    modules = [
      ./hardware-configuration.nix
      {
        networking.hostName = "chronos";
        system.stateVersion = "24.05";
        nix = {
          gc = {
            automatic = true;
            options = "--delete-older-than 10d";
          };
          settings.experimental-features = ["nix-command" "flakes"];
        };

        # Install git
        environment.systemPackages = with pkgs; [
          git
        ];
      }
    ];
  }
