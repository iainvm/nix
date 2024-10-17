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

  config = lib.mkMerge [
    {}

    (lib.mkIf config.zsh.enable
    {
      programs = {
        zsh = {
          enable = true;
          dotDir = ".config/zsh";
        };
      };
    })

    (lib.mkIf config.zsh.starship.enable
    {
      programs = {
        zsh = {
          initExtra = lib.mkIf config.zsh.starship.transientPrompt (builtins.readFile ./starship/transient.zsh);
        };

        starship = {
          enable = true;
          settings = import ./starship/themes/${config.zsh.starship.theme}.nix { inherit lib; };
        };
      };
    })
  ];
}
