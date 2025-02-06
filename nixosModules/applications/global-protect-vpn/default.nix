{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.applications.global-protect-vpn = {
    enable = lib.mkEnableOption "enable global-protect-vpn";
  };

  config = lib.mkIf config.core.applications.global-protect-vpn.enable {
    environment.systemPackages = with pkgs; [
      gpauth
      gpclient
    ];

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
