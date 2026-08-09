{
  lib,
  config,
  ...
}: {
  options.applications.obsidian = {
    enable = lib.mkEnableOption "enable obsidian";
  };

  config = lib.mkIf config.applications.obsidian.enable {
    programs.obsidian = {
      enable = true;

      defaultSettings.app = {
        alwaysUpdateLinks = true;
        spellcheck = true;
      };
    };
  };
}
