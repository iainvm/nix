{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.hardware.sound = {
    enable = lib.mkEnableOption "sound";
  };

  config = lib.mkIf config.core.hardware.sound.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      playerctl # Used to control players with media keys
      pavucontrol
    ];
  };
}
