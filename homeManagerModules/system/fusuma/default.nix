{
  lib,
  config,
  ...
}: {
  options.system.fusuma = {
    enable = lib.mkEnableOption "fusuma";
  };

  config = lib.mkIf config.system.fusuma.enable {
    services.fusuma = {
      enable = true;
    };
  };
}
