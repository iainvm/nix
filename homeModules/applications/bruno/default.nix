{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.bruno = {
    enable = lib.mkEnableOption "enable bruno";
  };

  config = lib.mkIf config.applications.bruno.enable {
    home.packages = with pkgs; [
      bruno
    ];
  };
}
