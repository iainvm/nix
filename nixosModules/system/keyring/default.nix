{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.system.keyring = {
    enable = lib.mkEnableOption "enable keyring";
  };

  config = lib.mkIf config.core.system.keyring.enable {
    services.gnome.gnome-keyring.enable = true;

    programs = {
      seahorse.enable = true;
      gnupg.agent.enable = true;
    };

    # Keyring stuff
    environment.systemPackages = with pkgs; [
      polkit
      libsecret
      pass
    ];
  };
}
