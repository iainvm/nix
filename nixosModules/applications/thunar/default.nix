{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.applications.thunar = {
    enable = lib.mkEnableOption "Thunar";
  };
  config = lib.mkIf config.core.applications.thunar.enable {
    services.gvfs = {
      enable = true;
    };

    programs.thunar = {
      enable = true;
      plugins = [pkgs.xfce.thunar-volman];
    };
  };
}
