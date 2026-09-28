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

    home.file = {
      ".config/git/ignore" = {
        source = ./files/ignore;
        target = ".config/git/ignore";
      };
    };

    home.activation.gitTemplateHooks = lib.mkIf config.cli.git.hooks.jira (
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        run install -D -m 755 ${./files/hooks/prepare-commit-msg} "$HOME/.config/git/init/hooks/prepare-commit-msg"
      ''
    );

    programs.git = {
      enable = true;

      settings = {
        user = {
          name = config.cli.git.name;
          email = config.cli.git.email;
        };

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
