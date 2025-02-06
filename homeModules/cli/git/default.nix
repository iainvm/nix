{
  lib,
  config,
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
    programs.git = {
      enable = true;

      userName = config.cli.git.name;
      userEmail = config.cli.git.email;

      extraConfig = {
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
