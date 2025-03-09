{
  lib,
  self,
  pkgs,
  config,
  system,
  inputs,
  nixpkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.core.users = {
    users = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          host = lib.mkOption {
            type = lib.types.str;
            description = "The maching name the user is on.";
          };
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
            default = pkgs.bash;
            description = "The shell of the user.";
          };
        };
      });
      description = "A set of users with their groups and extra groups.";
    };
  };

  config = {
    users = {
      users =
        lib.mapAttrs (name: user: {
          isNormalUser = true;
          group = name;
          extraGroups = user.extraGroups;
          home = "/home/${name}";
          shell = user.shell;
        })
        config.core.users.users;

      groups =
        lib.mapAttrs (name: user: {
          name = name;
          gid = lib.mkDefault null;
        })
        config.core.users.users;
    };

    home-manager = {
      backupFileExtension = "bkp";
      useGlobalPkgs = true;
      extraSpecialArgs = {inherit self system inputs nixpkgs;};
      users = lib.mapAttrs (name: user: let
        hmDir = "${name}@${user.host}";
      in
        import ../../homeConfigurations/${hmDir}/home.nix)
      config.core.users.users;
    };
  };
}
