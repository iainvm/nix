{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.protonme = {
    pass.enable = lib.mkEnableOption "proton-pass";
    desktop.enable = lib.mkEnableOption "proton-mail";
    vpn.enable = lib.mkEnableOption "proton-vpn";
  };

  config = lib.mkMerge [
    {}

    (
      lib.mkIf config.applications.protonme.pass.enable
      {
        home.packages = with pkgs; [
          proton-pass
        ];
      }
    )

    (
      lib.mkIf config.applications.protonme.desktop.enable
      {
        home.packages = with pkgs; [
          protonmail-desktop
        ];
      }
    )
    (
      lib.mkIf config.applications.protonme.vpn.enable
      {
        home.packages = with pkgs; [
          protonvpn-gui
        ];
      }
    )
  ];
}
