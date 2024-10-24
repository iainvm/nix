{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.swappy = {
    enable = lib.mkEnableOption "swappy";
  };

  config = lib.mkIf config.applications.swappy.enable {
    home.file = {
      swappy = {
        source = ./scripts;
        target = ".config/swappy/";
        recursive = true;
      };
    };

    home.packages = with pkgs; [
      grim
      slurp
      swappy
    ];
  };
}
