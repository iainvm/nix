{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.gram = {
    enable = lib.mkEnableOption "gram";
  };

  config = lib.mkIf config.applications.gram.enable {
    home.packages = with pkgs; [
      gram
    ];
  };
}
