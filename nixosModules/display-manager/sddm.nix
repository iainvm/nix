{
  lib,
  pkgs,
  config,
  system,
  nixpkgs,
  ...
}: {
  options.sddm = {
    enable = lib.mkEnableOption "enable sddm";
  };

  config = lib.mkIf config.sddm.enable {
    services.xserver.enable = true;

    services.displayManager.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };

    security.pam.services.sddm.enableGnomeKeyring = true;

    # Keyring stuff
    environment.systemPackages = with pkgs; [
      polkit
      libsecret
      gnupg
      pinentry-curses
    ];
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
  };
}
