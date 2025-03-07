{
  lib,
  config,
  inputs,
  ...
}: let
  system = builtins.currentSystem;
in {
  options.applications.zen = {
    enable = lib.mkEnableOption "enable zen";
  };

  config = lib.mkIf config.applications.zen.enable {
    home.packages = [
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
