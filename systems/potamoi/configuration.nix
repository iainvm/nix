{
  nixpkgs,
  nixos-wsl,
  ...
}: let
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in
  nixpkgs.lib.nixosSystem {
    system = system;

    modules = [
      nixos-wsl.nixosModules.default
      {
        wsl.enable = true;
        wsl.defaultUser = "iain";
        networking.hostName = "potamoi";
        system.stateVersion = "24.05";
      }
      {
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
