{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.discord = {
    enable = lib.mkEnableOption "discord";
  };

  config = lib.mkIf config.applications.discord.enable {
    home.packages = with pkgs; [
      discord
      vesktop
    ];
  };
}
