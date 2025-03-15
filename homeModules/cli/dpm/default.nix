{
  lib,
  config,
  inputs,
  system,
  ...
}: let
  dpm = inputs.dpm.packages."${system}".default;
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
