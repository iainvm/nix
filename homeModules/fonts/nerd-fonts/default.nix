{
  lib,
  config,
  pkgs,
  ...
}: {
  options.fonts.nerd-fonts = {
    enable = lib.mkEnableOption "enable nerd-fonts";
  };

  config = lib.mkIf config.fonts.nerd-fonts.enable {
    fonts.fontconfig.enable = true;
    home.packages = [
      pkgs.nerd-fonts.hack
      pkgs.nerd-fonts.meslo-lg
    ];
  };
}
