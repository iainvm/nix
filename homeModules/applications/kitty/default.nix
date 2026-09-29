{
  lib,
  config,
  ...
}: {
  options.applications.kitty = {
    enable = lib.mkEnableOption "enable kitty";
  };

  config = lib.mkIf config.applications.kitty.enable {
    programs.kitty = {
      enable = true;

      settings = {
          remember_window_size = "no"; # Fix to launching fullscreen
      };
    };
  };
}
