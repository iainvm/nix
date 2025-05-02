{
  lib,
  config,
  ...
}: {
  options.core.display-manager.sddm = {
    enable = lib.mkEnableOption "enable sddm";
  };

  config = lib.mkIf config.core.display-manager.sddm.enable {
    services.xserver.enable = true;

    services.displayManager.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };

    security.pam.services.sddm.enableGnomeKeyring = true;

    core.system.keyring.enable = true;
  };
}
