{
  lib,
  config,
  pkgs,
  ...
}: {
  options.core.hardware.thunderbolt = {
    enable = lib.mkEnableOption "thunderbolt";
  };

  config = lib.mkIf config.core.hardware.thunderbolt.enable {
    services.hardware.bolt.enable = true;

    boot.extraModulePackages = with config.boot.kernelPackages; [evdi];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [displaylink];
    };

    services.xserver = {
      enable = true;
      videoDrivers = ["modesetting" "displaylink"];
    };
  };
}
