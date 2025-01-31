{
  lib,
  pkgs,
  config,
  system,
  nixpkgs,
  ...
}: {
  options.core.system.ly = {
    enable = lib.mkEnableOption "enable ly";
  };

  config = lib.mkIf config.core.system.ly.enable {
    services.displayManager.ly = {
      enable = true;
    };
  };
}
