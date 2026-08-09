{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.applications.tailscale = {
    enable = lib.mkEnableOption "tailscale";
    keyFile = lib.mkOption {
      type = lib.types.str;
      default = "/run/secrets/tailscale_key";
    };
  };
  config = lib.mkIf config.core.applications.tailscale.enable {
    services.tailscale = {
      enable = true;
      authKeyFile = config.core.applications.tailscale.keyFile;
    };
  };
}
