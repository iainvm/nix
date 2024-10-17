{
  lib,
  config,
  ...
}: {
  options.zsh = {
    enable = lib.mkEnableOption "enable zsh";

    starship = {
      enable = lib.mkEnableOption "enable starship";
      transientPrompt = lib.mkEnableOption "enable transient prompt";
      theme = lib.mkOption {
        type = lib.types.str;
        default = "tokyo-night";
      };
    };
  };

  config = lib.mkIf config.zsh.enable {

    # Pure ZSH configuration
    programs = {
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
      };
    }

    # Starship configuration
    // lib.mkIf config.zsh.starship.enable {
      # Transient prompt
      zsh = {
        initExtra = lib.mkIf config.zsh.starship.transientPrompt (builtins.readFile ./starship/transient.zsh);
      };

      starship = {
        enable = true;
        settings = import ./starship/themes/${config.zsh.starship.theme}.nix { inherit lib; };
      };
    };
  };
}
