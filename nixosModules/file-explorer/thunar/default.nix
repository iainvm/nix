{
  lib,
  pkgs,
  ...
}: {
  options = {
    file-explorer.thunar = lib.mkEnableOption "Thunar";
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
