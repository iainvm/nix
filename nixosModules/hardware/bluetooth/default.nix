{
  lib,
  config,
  ...
}: {
  options.core.hardware.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf config.core.hardware.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };
}
