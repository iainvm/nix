{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.prism = {
    enable = lib.mkEnableOption "prism";
  };

  config = lib.mkIf config.applications.prism.enable {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
