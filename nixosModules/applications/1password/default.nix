{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.applications._1password = {
    enable = lib.mkEnableOption "1password";
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["iain"];
      description = "A list of users to be added to the polkit policy group.";
    };
  };

  config = lib.mkIf config.core.applications._1password.enable {
    programs = {
      _1password = {
        enable = true;
        package = pkgs._1password-cli;
      };
      _1password-gui = {
        enable = true;
        package = pkgs._1password-gui;
        polkitPolicyOwners = config.core.applications._1password.users;
      };
    };

    security.pam.services._1password.enableGnomeKeyring = true;
  };
}
