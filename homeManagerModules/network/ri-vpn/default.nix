{
  lib,
  pkgs,
  config,
  ...
}: {
  options.network.ri-vpn = {
    enable = lib.mkEnableOption "enable ri-vpn";
  };

  config = lib.mkIf config.network.ri-vpn.enable {
    systemd.user.services.ri-vpn = {
      Unit = {
        Description = "RI VPN Service";
      };
      Install = {
        WantedBy = [];
      };
      Service = {
        ExecStart = "/run/wrappers/bin/sudo gpclient connect vpn.river-island.com";
      };
    };
  };
}
