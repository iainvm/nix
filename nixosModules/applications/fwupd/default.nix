{
  lib,
  config,
  ...
}: {
  options.core.applications.fwupd = {
    enable = lib.mkEnableOption "fwupd";
  };
  config = lib.mkIf config.core.applications.fwupd.enable {
    services.fwupd = {
      enable = true;
    };
  };
}
