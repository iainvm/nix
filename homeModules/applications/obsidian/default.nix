{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.obsidian = {
    enable = lib.mkEnableOption "enable obsidian";
  };

  config = lib.mkIf config.applications.obsidian.enable {
    programs.obsidian = {
      enable = true;

      vaults = {
        "main" = {
          enable = true;
          target = "obsidian/main";
          settings = {
            communityPlugins = with pkgs.obsidianPlugins; [
              {
                pkg = obsidian-livesync;
                enable = true;
              }
            ];
          };
        };
      };

      defaultSettings = {
        app = {
          alwaysUpdateLinks = true;
          spellcheck = true;
        };
      };
    };
  };
}
