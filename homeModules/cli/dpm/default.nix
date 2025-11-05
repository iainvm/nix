{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  dpm = inputs.dpm.packages."${pkgs.stdenv.hostPlatform.system}".default;
in {
  options.cli.dpm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the dpm package.";
    };
  };

  config = lib.mkIf config.cli.dpm.enable {
    home.packages = [dpm];
  };
}
