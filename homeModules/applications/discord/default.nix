{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.vesktop = {
    enable = lib.mkEnableOption "vesktop";
  };

  config = lib.mkIf config.applications.vesktop.enable {
    home.packages = with pkgs; [
      vesktop
    ];
  };
}
