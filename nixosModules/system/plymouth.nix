{
  lib,
  config,
  system,
  nixpkgs,
  ...
}: let
  pkgs = nixpkgs.legacyPackages.${system};
in {
  options.plymouth = {
    enable = lib.mkEnableOption "enable plymouth";
  };

  config = lib.mkIf config.plymouth.enable {
    # Plymouth needs systemd initrd
    boot.initrd.systemd.enable = true;
    boot.plymouth = {
      enable = true;
      theme = "hexagon_2";
      themePackages = [
        pkgs.adi1090x-plymouth-themes
      ];
    };
  };
}
