{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.applications.steam = {
    enable = lib.mkEnableOption "Steam";
  };
  config = lib.mkIf config.core.applications.steam.enable {
    programs.steam = {
      enable = true;
      # remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
      # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };
}
