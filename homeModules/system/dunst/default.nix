{
  lib,
  config,
  ...
}: {
  options.system.dunst = {
    enable = lib.mkEnableOption "dunst";
  };

  config = lib.mkIf config.system.dunst.enable {
    services.dunst = {
      enable = true;
    };
  };
}
