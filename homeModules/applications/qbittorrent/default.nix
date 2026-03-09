{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.qbittorrent = {
    enable = lib.mkEnableOption "qbittorrent";
  };

  config = lib.mkIf config.applications.qbittorrent.enable {
    home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
