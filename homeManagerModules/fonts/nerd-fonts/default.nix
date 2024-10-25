{
  lib,
  config,
  pkgs,
  ...
}: {
  options.fonts.nerd-fonts = {
    enable = lib.mkEnableOption "enable nerd-fonts";

    # List of fonts to install
    fonts = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["Hack" "Meslo"];
      example = ["Hack" "FiraCode"];
    };
  };

  config = lib.mkIf config.fonts.nerd-fonts.enable {
    fonts.fontconfig.enable = true;
    home.packages = [
      (pkgs.nerdfonts.override {fonts = config.fonts.nerd-fonts.fonts;})
    ];
  };
}
