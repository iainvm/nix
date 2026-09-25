{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.crush = {
    enable = lib.mkEnableOption "enable crush";
  };

  config = lib.mkIf config.applications.crush.enable {
    home.packages = with pkgs; [
      crush
    ];
  };
}
