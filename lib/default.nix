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
    system,
    modules ? [],
    overlays ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit self system inputs nixpkgs;};
      modules =
        [
          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = defaultOverlays ++ overlays;
            };
          }
          inputs.self.nixosModules.default
          ../nixosConfigurations/${name}/hardware-configuration.nix
          ../nixosConfigurations/${name}/configuration.nix
        ]
        ++ modules;
    };

  mkHomeConfigurations = {
    dir,
    system,
    modules ? [],
    overlays ? [],
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."${system}";
      extraSpecialArgs = {inherit self system inputs nixpkgs;};
      modules =
        [
          {nixpkgs.config.allowUnfree = true;}
          {nixpkgs.overlays = defaultOverlays ++ overlays;}
          inputs.self.homeModules.default
          ../homeConfigurations/${dir}/home.nix
        ]
        ++ modules;
    };
}
