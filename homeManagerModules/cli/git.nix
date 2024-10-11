{
  lib,
  config,
  ...
}: {
  options.git = {
    enable = lib.mkEnableOption "enable git";

    name = lib.mkOption {
      type = lib.types.str;
      description = "The users name";
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "The users email";
    };
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;

      userName = config.git.name;
      userEmail = config.git.email;

      extraConfig = {
        init = {
          defaultBranch = "main";
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
