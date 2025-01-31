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
    environment.systemPackages = with pkgs; [
      gpclient
    ];

    security.sudo.extraRules = [
      {
        users = ["privileged_user"];
        commands = [
          {
            command = "/run/current-system/sw/bin/gpclient";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };
}
