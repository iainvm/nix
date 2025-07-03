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
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
    services.blueman.enable = true;
  };
}
