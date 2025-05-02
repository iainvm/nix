{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  options.applications.stylix = {
    enable = lib.mkEnableOption "enable stylix";
    theme = lib.mkOption {
      type = lib.types.str;
      # https://tinted-theming.github.io/tinted-gallery/
      default = "darkmoss";
    };
    firefox-profiles = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["iain"];
      description = "A list of firefox profiles to apply to.";
    };
  };

  config = lib.mkIf config.applications.stylix.enable {
    stylix = {
      enable = true;
      autoEnable = false;

      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.applications.stylix.theme}.yaml";

      targets = {
        # https://stylix.danth.me/options/modules/firefox.html
        btop.enable = true;
        dunst.enable = true;
        firefox = {
          enable = true;
          profileNames = config.applications.stylix.firefox-profiles;
        };
        gnome.enable = true;
        gtk.enable = true;
        kitty.enable = true;
        vscode.enable = true;
        wofi.enable = true;
      };
    };
  };
}
