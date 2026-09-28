{
  lib,
  config,
  ...
}: {
  options.core.display-manager.ly = {
    enable = lib.mkEnableOption "enable ly";
  };

  config = lib.mkIf config.core.display-manager.ly.enable {
    services.displayManager = {
      enable = true;
      ly = {
        enable = true;
      };
    };

    security.pam = {
      services.login = {
        enableGnomeKeyring = true;
        fprintAuth =
          lib.mkIf config.core.hardware.fingerprint-reader.enable
          true;
      };
      services.ly.enableGnomeKeyring = true;
    };
  };
}
