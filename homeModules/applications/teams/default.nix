{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.teams = {
    enable = lib.mkEnableOption "teams";
  };

  config = lib.mkIf config.applications.teams.enable {
    home.packages = with pkgs; [
      teams-for-linux
    ];
  };
}
