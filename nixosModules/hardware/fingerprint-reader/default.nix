{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.hardware.fingerprint-reader = {
    enable = lib.mkEnableOption "enable fingerprint-reader";
  };

  config = lib.mkIf config.core.hardware.fingerprint-reader.enable {
    services.fprintd = {
      enable = true;
      tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-goodix;
    };

    # 4. Optional: Enable for sudo
    security.pam.services.sudo.fprintAuth = true;
    security.pam.services.sudo-root.fprintAuth = true;
  };
}
