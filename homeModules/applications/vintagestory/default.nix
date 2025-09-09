{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.vintagestory = {
    enable = lib.mkEnableOption "vintagestory";
  };

  config = lib.mkIf config.applications.vintagestory.enable {
    home.packages = with pkgs; [
      vintagestory
    ];
  };
}
