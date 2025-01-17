{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.anytype = {
    enable = lib.mkEnableOption "anytype";
  };

  config = lib.mkIf config.applications.anytype.enable {
    home.packages = with pkgs; [
      anytype
    ];
  };
}
