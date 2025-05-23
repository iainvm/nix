{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cli.git = {
    enable = lib.mkEnableOption "enable git";

    name = lib.mkOption {
      type = lib.types.str;
      description = "The users name";
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "The users email";
    };

    hooks = {
      jira = lib.mkEnableOption "enable jira pre-commit hooks";
    };
  };

  config = lib.mkIf config.cli.git.enable {
    home.packages = with pkgs; [
      delta
    ];

    programs.git = {
      enable = true;

      userName = config.cli.git.name;
      userEmail = config.cli.git.email;

      extraConfig = {
        core = {
          pager = "delta";
        };

        interactive = {
          diffFilter = "delta == color-only";
        };

        delta = {
          navigation = true;
          dark = true;
        };

        merge = {
          conflictstyle = "zdiff3";
        };

        init = {
          defaultBranch = "main";
          templatedir = "~/.config/git/init";
        };

        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com/";
          };
        };
      };
    };
  };
}
