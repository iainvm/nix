{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.applications.global-protect = {
    enable = lib.mkEnableOption "global-protect";
  };

  config = lib.mkIf config.core.applications.global-protect.enable {
    services.globalprotect.enable = true;

    security.sudo.extraRules = [
      {
        users = ["ALL"];
        commands = [
          {
            command = "/run/current-system/sw/bin/gpclient";
            options = ["NOPASSWD" "SETENV"];
          }
        ];
      }
    ];
  };
}
