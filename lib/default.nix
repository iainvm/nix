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
    arch,
    modules ? [],
    overlays ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      system = arch;
      specialArgs = {inherit self inputs nixpkgs;};
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
    arch,
    modules ? [],
    overlays ? [],
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."${arch}";
      extraSpecialArgs = {inherit self inputs nixpkgs;};
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
