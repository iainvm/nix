{
  lib,
  config,
  nixpkgs,
  ...
}: {
  options.applications.kitty = {
    enable = lib.mkEnableOption "enable kitty";
  };

  config = lib.mkIf config.applications.kitty.enable {
    programs.kitty = {
      enable = true;
    };
  };
}
