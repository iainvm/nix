{
   inputs,
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
    user,
    host,
    arch,
    pkgs,
    modules ? [],
    overlays ? [],
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules =
        [
          ./homeConfigurations/"${user}@${host}"/home.nix
        ]
        ++ modules;
    };
}
