{
  lib,
  self,
  config,
  nixpkgs,
  system,
  inputs,
  ...
}: let
  pkgs = nixpkgs.legacyPackages.${system};
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.simple-users = {
    users = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          group = lib.mkOption {
            type = lib.types.str;
            description = "The primary group of the user.";
          };
          extraGroups = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = "A list of extra groups the user should be a member of.";
          };
          shell = lib.mkOption {
            type = lib.types.nullOr (lib.types.either lib.types.shellPackage (lib.types.passwdEntry lib.types.path));
            default = pkgs.shadow;
            description = "The shell of the user.";
          };

          home-manager = lib.mkOption {
            type = lib.types.path;
            description = "The home-manager configuration for the user.";
          };
        };
      });
      description = "A set of users with their groups and extra groups.";
    };
  };

  config = {
    # Install shell
    # environment.systemPackages = lib.mapAttrs (name: user: user.shell) config.simple-users.users;
    environment.systemPackages = [pkgs.fish];

    users = {
      users =
        lib.mapAttrs (name: user: {
          isNormalUser = true;
          group = name;
          extraGroups = user.extraGroups or [];
          home = "/home/${name}";
          shell = user.shell;
          # Add more user attributes as needed
        })
        config.simple-users.users;

      groups =
        lib.mapAttrs (name: user: {
          name = name;
          gid = lib.mkDefault null;
        })
        config.simple-users.users;
    };

    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users =
        lib.mapAttrs (name: user: import user.home-manager)
        config.simple-users.users;
    };
  };
}
