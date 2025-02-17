{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.datagrip = {
    enable = lib.mkEnableOption "datagrip";
  };

  config = lib.mkIf config.applications.datagrip.enable {
    home.packages = with pkgs; [
      jetbrains.datagrip
    ];
  };
}
