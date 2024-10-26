{
  lib,
  config,
  ...
}: {
  options.core.system.language.en-gb = {
    enable = lib.mkEnableOption "enable en-gb";
  };

  config = lib.mkIf config.core.system.language.en-gb.enable {
    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };

    console.keyMap = "uk";
    services.xserver.xkb.layout = "gb";
    services.xserver.xkb.variant = "";

    time.timeZone = "Europe/London";
  };
}
