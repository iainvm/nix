{
  lib,
  pkgs,
  config,
  ...
}: {
  options.cli.task = {
    enable = lib.mkEnableOption "task";
  };

  config = lib.mkIf config.cli.task.enable {
    home.packages = with pkgs; [
      go-task
    ];
  };
}
