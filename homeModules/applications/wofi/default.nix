{
  lib,
  config,
  ...
}: {
  options.applications.wofi = {
    enable = lib.mkEnableOption "enable wofi";
  };

  config = lib.mkIf config.applications.wofi.enable {
    programs.wofi = {
      enable = true;
    };
  };
}
