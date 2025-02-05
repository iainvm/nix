{
  self,
  inputs,
  nixpkgs,
}: {
  mkNixOSConfigurations = {
    name,
    arch,
    users,
    modules ? [],
    overlays ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      system = arch;
      modules =
        [
          {nixpkgs.overlays = overlays;}
          self.nixosModules.default
          import
          ./nixosConfigurations/${name}/configuration.nix
          {inherit self inputs nixpkgs;}
        ]
        ++ modules;
    };

  mkHomeConfigurations = {
    dir,
    pkgs,
    modules ? [],
    overlays ? [],
  }:{
    "${dir}" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit self inputs nixpkgs; };
      modules =
        [
          { nixpkgs.config.allowUnfree = true; }
          {nixpkgs.overlays = [inputs.nur.overlays.default];}
          ../homeConfigurations/${dir}/home.nix
        ]
        ++ modules;
    };
  };
}
