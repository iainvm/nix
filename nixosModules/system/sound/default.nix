{
  lib,
  config,
  nixpkgs,
  ...
}: {
  options.system.sound = {
    enable = lib.mkEnableOption "sound";
  };

  config = lib.mkIf config.system.sound.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
