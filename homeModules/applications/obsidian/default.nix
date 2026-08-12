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
              obsidian-livesync # Backup and Sync Obsidian vault to NAS
              project-manager # Manages projects and tasks, and renders kanban and gantt charts
              obsidian-media-db-plugin # Allows of easy importing of data about various media (movies, shows, boardgames...)
            ];
          };
        };

        "work" = {
          enable = true;
          target = "obsidian/work";
          settings = {
            communityPlugins = with pkgs.obsidianPlugins; [
              obsidian-livesync
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
