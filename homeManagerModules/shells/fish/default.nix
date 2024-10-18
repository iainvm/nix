{
  lib,
  config,
  ...
}: {
  options.shells.fish = {
    enable = lib.mkEnableOption "enable fish";

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

    (lib.mkIf config.shells.fish.enable
      {
        programs = {
          fish = {
            enable = true;
          };
        };
      })

    (lib.mkIf config.shells.fish.starship.enable
      {
        programs = {
          starship = {
            enable = true;
            enableTransience = lib.mkIf config.shells.fish.starship.transientPrompt true;
            settings = import ./starship/themes/${config.shells.fish.starship.theme}.nix {inherit lib;};
          };
        };
      })
  ];
}
