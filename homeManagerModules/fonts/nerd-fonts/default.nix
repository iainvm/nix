{
  lib,
  config,
  ...
}: {
  options.fonts.nerd-fonts = {
    enable = lib.mkEnableOption "enable direnv";
  };

  config = lib.mkIf config.fonts.nerd-fonts.enable {
    fonts.fontconfig.enable = true;
    home.packages = [
      (pkgs.nerdfonts.override { fonts = [ "Agave" "Hack" ]; })
    ];
  };
}
