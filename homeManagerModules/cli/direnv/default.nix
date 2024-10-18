{
  lib,
  config,
  ...
}: {
  options.cli.direnv = {
    enable = lib.mkEnableOption "enable direnv";
  };

  config = lib.mkIf config.cli.direnv.enable {
    programs.direnv = {
      enable = true;

      config = {
        global = {
          hide_env_diff = true;
        };
      };
    };
  };
}
