{
  self,
  inputs,
  nixpkgs,
}: let
  defaultOverlays = [
    inputs.nur.overlays.default
    inputs.nix-vscode-extensions.overlays.default
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
