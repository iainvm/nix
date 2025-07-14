{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.vlc = {
    enable = lib.mkEnableOption "vlc";
  };

  config = lib.mkIf config.applications.vlc.enable {
    home.packages = with pkgs; [
      vlc
    ];
  };
}
