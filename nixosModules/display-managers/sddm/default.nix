{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.display-manager.sddm = {
    enable = lib.mkEnableOption "enable sddm";
    disabled-displays = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of display IDs to disable.";
    };
  };

  config = lib.mkIf config.core.display-manager.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      autoNumlock = true;

      # wayland.enable = true;

      theme = "sddm-astronaut-theme";
      package = pkgs.kdePackages.sddm;
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

    core.system.keyring.enable = true;
    security.pam.services.sddm.enableGnomeKeyring = true;
  };
}
