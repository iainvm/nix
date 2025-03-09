{
  lib,
  config,
  inputs,
  system,
  ...
}: let
  zen-browser = inputs.zen-browser.packages."${system}".default;
in {
  options.applications.zen = {
    enable = lib.mkEnableOption "enable zen";
  };

  config = lib.mkIf config.applications.zen.enable {
    home.packages = [
      zen-browser
    ];
  };
}
