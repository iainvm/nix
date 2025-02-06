{
  lib,
  config,
  ...
}: {
  options.applications.wofi = {
    enable = lib.mkEnableOption "enable wofi";
  };

  config = lib.mkIf config.applications.wofi.enable {
    home.file = {
      ".config/wofi" = {
        source = ./dotfiles;
        target = ".config/wofi/";
        recursive = true;
      };
    };

    programs.wofi = {
      enable = true;
    };
  };
}
