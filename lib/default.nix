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
    nixpkgs.lib.nixosSystem {
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

  # mkHomeConfigurations = {
  #   host,
  #   nixpkgs,
  #   home-manager,
  #   modules ? [],
  # }:
  #   home-manager.lib.homeManagerConfiguration {
  #     pkgs = import nixpkgs {
  #       system = arch;
  #       config = {
  #         allowUnfree = true;
  #       };
  #     };
  #     modules =
  #       [
  #         ./hosts/${host.dir}/home.nix
  #       ]
  #       ++ modules;
  #   };
}
