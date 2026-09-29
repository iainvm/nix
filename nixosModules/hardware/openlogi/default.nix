{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.openlogi.nixosModules.default
  ];

  options.core.hardware.openlogi = {
    enable = lib.mkEnableOption "enable openlogi";
  };

  config = lib.mkIf config.core.hardware.openlogi.enable {
    programs.openlogi.enable = true;
  };
}
