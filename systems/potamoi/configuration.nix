{
  self,
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
      self.nixosModules.nix-flakes
      {
        nix-flakes.enable = true;
        wsl.enable = true;
        wsl.defaultUser = "iain";
        networking.hostName = "potamoi";
        system.stateVersion = "24.05";

        environment.systemPackages = with pkgs; [
          git
        ];
      }
    ];
  }
