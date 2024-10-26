{
  lib,
  config,
  ...
}: {
  options.core.hardware.network = {
    enable = lib.mkEnableOption "enable network";
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "Host name of the device";
    };
  };

  config = lib.mkIf config.core.hardware.network.enable {
    networking = {
      networkmanager.enable = true;
      hostName = config.core.hardware.network.hostName;
    };
  };
}
