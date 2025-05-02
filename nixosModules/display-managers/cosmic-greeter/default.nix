{
  lib,
  config,
  ...
}: {
  options.core.display-manager.cosmic-greeter = {
    enable = lib.mkEnableOption "enable cosmic-greeter";
  };

  config = lib.mkIf config.core.display-manager.cosmic-greeter.enable {
    services.displayManager.cosmic-greeter = {
      enable = true;
    };
    # security.pam.services.cosmic-greeter = {
    #   startSession = true;
    #   unixAuth = true;
    #   enableGnomeKeyring = lib.mkDefault config.services.gnome.gnome-keyring.enable;
    # };
  };
}
