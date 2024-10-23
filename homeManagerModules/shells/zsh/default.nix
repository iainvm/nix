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
    initExtra = zshModule.options.programs.zsh.initExtra;
    aliases = zshModule.options.programs.zsh.shellAliases;

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
          fzf = {
            enable = true;
          };

          zsh = {
            enable = true;
            dotDir = ".config/zsh";
            plugins = config.shells.zsh.plugins;
            initExtra = config.shells.zsh.initExtra;
            shellAliases = config.shells.zsh.aliases;
          };

          eza = {
            enable = true;
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
