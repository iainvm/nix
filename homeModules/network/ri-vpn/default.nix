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
        ExecStart = "/run/wrappers/bin/sudo gpclient --fix-openssl connect vpn.river-island.com";
      };
    };

    home.packages = with pkgs; [
      (writeScriptBin "rivpn" ''
        case "$1" in
          start)
            systemctl --user start ri-vpn.service
            ;;
          stop)
            systemctl --user stop ri-vpn.service
            ;;
          status)
            systemctl --user status ri-vpn.service
            ;;
          *)
            echo "Usage: rivpn {start|stop|status}"
            ;;
        esac
      '')
    ];
  };
}
