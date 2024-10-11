{
  lib,
  config,
  ...
}: {
  options.network = {
    enable = lib.mkEnableOption "enable network";
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "Domain name of the device";
    };
  };

  config = lib.mkIf config.network.enable {
    networking = {
      networkmanager.enable = true;
      hostName = config.network.hostName;
    };
  };
}
