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

    programs.xfconf.enable = true; # Needed to save preferences
    environment.systemPackages = with pkgs; [
      file-roller
    ];

    services = {
      gvfs.enable = true;
      tumbler.enable = true;
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
