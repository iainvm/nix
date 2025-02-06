{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.stremio = {
    enable = lib.mkEnableOption "stremio";
  };

  config = lib.mkIf config.applications.stremio.enable {
    home.packages = with pkgs; [
      stremio
    ];
  };
}
