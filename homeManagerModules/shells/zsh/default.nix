{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  zshModule = import "${inputs.home-manager}/modules/programs/zsh.nix" {inherit pkgs lib config;};
in {
  options.shells.zsh = {
    enable = lib.mkEnableOption "enable zsh";
    plugins = zshModule.options.programs.zsh.plugins;

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

    (lib.mkIf config.shells.zsh.enable
      {
        programs = {
          zsh = {
            enable = true;
            dotDir = ".config/zsh";
            plugins = config.shells.zsh.plugins;
          };
        };
      })

    (lib.mkIf config.shells.zsh.starship.enable
      {
        programs = {
          zsh = {
            initExtra = lib.mkIf config.shells.zsh.starship.transientPrompt (builtins.readFile ./starship/transient.zsh);
          };

          starship = {
            enable = true;
            settings = import ./starship/themes/${config.shells.zsh.starship.theme}.nix {inherit lib;};
          };
        };
      })
  ];
}
