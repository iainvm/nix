{
  lib,
  config,
  system,
  nixpkgs,
  ...
}: let
  pkgs = nixpkgs.legacyPackages.${system};
in {
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

    security.pam.services.gdm-password.enableGnomeKeyring = true;

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
