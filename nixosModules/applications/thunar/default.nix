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
    xdg.mime.defaultApplications = {
      "inode/directory" = ["thunar.desktop"];
    };

    services.gvfs = {
      enable = true;
    };

    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-volman
        thunar-archive-plugin
      ];
    };
  };
}
