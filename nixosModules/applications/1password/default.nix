{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications."1password" = {
    enable = lib.mkEnableOption "1password";
  };

  config = lib.mkIf config.applications."1password".enable {
    programs = {
      _1password = {
        enable = true;
        package = pkgs._1password;
      };
      _1password-gui = {
        enable = true;
        package = pkgs._1password-gui;
        polkitPolicyOwners = ["iain"]; # TODO: Make this configurable
      };
    };

    security.pam.services."1password".enableGnomeKeyring = true;
  };
}
