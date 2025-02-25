{
  lib,
  config,
  inputs,
  ...
}: {
  options.applications.zen = {
    enable = lib.mkEnableOption "enable zen";
  };

  config = lib.mkIf config.applications.zen.enable {
    home.packages = [
      inputs.zen-browser.packages."x86_64-linux".default
    ];
  };
}
