{
  lib,
  config,
  ...
}: {
  options.system.fusuma = {
    enable = lib.mkEnableOption "fusuma";
  };

  config = lib.mkIf config.system.fusuma.enable {
    # Multitouch gestures with libinput
    services.fusuma = {
      enable = true;
    };
  };
}
