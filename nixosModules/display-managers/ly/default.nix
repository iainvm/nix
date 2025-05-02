{
  lib,
  config,
  ...
}: {
  options.core.display-manager.ly = {
    enable = lib.mkEnableOption "enable ly";
  };

  config = lib.mkIf config.core.display-manager.ly.enable {
    services.displayManager.ly = {
      enable = true;
    };
  };
}
