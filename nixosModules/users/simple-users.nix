{
  lib,
  config,
  ...
}: {
  options.simple-users = {
    users = lib.mkOption {
      type = lib.types.attrsOf (lib.types.attrsOf lib.types.str);
      default = {};
      description = "Simple users";
    };
  };

  config = {
    users = {
      users = lib.mapAttrs (name: user: {
        isNormalUser = true;
        group = name;
        extraGroups = [ "wheel" ];
        home = "/home/${name}";
        shell = "/run/current-system/sw/bin/bash";
        # Add more user attributes as needed
      }) config.simple-users.users;

      groups = lib.mapAttrs (name: user: {
        name = name;
        gid = lib.mkDefault null; # You can set a specific GID if needed
      }) config.simple-users.users;
    };
  };
}
