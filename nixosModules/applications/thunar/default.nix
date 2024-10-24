{
  lib,
  pkgs,
  ...
}: {
  options.applications.thunar = {
    enable = lib.mkEnableOption "Thunar";
  };
  config = {
    services.gvfs = {
      enable = true;
    };

    programs.thunar = {
      enable = true;
      plugins = [pkgs.xfce.thunar-volman];
    };
  };
}
