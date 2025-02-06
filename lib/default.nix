{
  self,
  inputs,
  nixpkgs,
}: {
  mkNixosConfigurations = {
    name,
    arch,
    modules ? [],
    overlays ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      system = arch;
      specialArgs = { inherit self inputs nixpkgs; };
      modules =
        [
          { nixpkgs.config.allowUnfree = true; }
          {nixpkgs.overlays = overlays;}
          inputs.self.nixosModules.default
          ../nixosConfigurations/${name}/hardware-configuration.nix
          ../nixosConfigurations/${name}/configuration.nix
        ]
        ++ modules;
    };

  mkHomeConfigurations = {
    dir,
    pkgs,
    modules ? [],
    overlays ? [],
  }: 
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit self inputs nixpkgs; };
      modules =
        [
          { nixpkgs.config.allowUnfree = true; }
          {nixpkgs.overlays = overlays;}
          inputs.self.homeModules.default
          ../homeConfigurations/${dir}/home.nix
        ]
        ++ modules;
    };
}
