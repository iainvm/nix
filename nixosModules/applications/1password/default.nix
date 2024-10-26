{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.applications._1password = {
    enable = lib.mkEnableOption "1password";
  };

  config = lib.mkIf config.core.applications._1password.enable {
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

    security.pam.services._1password.enableGnomeKeyring = true;
  };
}
