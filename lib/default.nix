{
  self,
  inputs,
  nixpkgs,
}: let
  defaultOverlays = [
    inputs.nur.overlays.default
    inputs.nix-vscode-extensions.overlays.default
    inputs.obsidian-extensions.overlays.default
  ];
in {
  mkNixosConfigurations = {
    name,
    modules ? [],
    overlays ? [],
    permitInsecure ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit self inputs nixpkgs;};
      modules =
        [
          {
            nixpkgs = {
              config = {
                allowUnfree = true;
                permittedInsecurePackages = permitInsecure;
              };
              overlays = defaultOverlays ++ overlays;
            };
            nix.settings = {
              substituters = [
                "https://nix-community.cachix.org"
                "https://cache.nixos.org/"
              ];
              trusted-substituters = [
                "https://hyprland.cachix.org"
              ];
              trusted-public-keys = [
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
              ];
              # Required so non-root users are allowed to use the above substituter/keys.
              # Use @wheel for all sudo users, or list your username explicitly.
              trusted-users = ["root" "@wheel"];
            };
          }
          inputs.self.nixosModules.default
          inputs.sops-nix.nixosModules.sops
          {
            sops = {
              defaultSopsFile = ./secrets/secrets.yaml;
              defaultSopsFormat = "yaml";
              age.keyFile = "~/.config/sops/age/keys.txt";
            };
          }
          ../nixosConfigurations/${name}/hardware-configuration.nix
          ../nixosConfigurations/${name}/configuration.nix
        ]
        ++ modules;
    };
}
