{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.display-manager.sddm = {
    enable = lib.mkEnableOption "enable sddm";
  };

  config = lib.mkIf config.core.display-manager.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      wayland.enable = true;
      autoNumlock = true;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
      ];
    };

    environment.systemPackages = with pkgs; [
      (sddm-astronaut.override {
        embeddedTheme = "astronaut";
      })
    ];

    security.pam.services.sddm.enableGnomeKeyring = true;

    core.system.keyring.enable = true;
  };
}
