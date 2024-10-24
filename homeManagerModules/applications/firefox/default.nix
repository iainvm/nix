{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.firefox = {
    enable = lib.mkEnableOption "enable firefox";
  };

  config = lib.mkIf config.applications.firefox.enable {
    programs.firefox = {
      enable = true;

      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          DisableTelemetry = true;

          ExtensionSettings = import ./extensions.nix;
          Preferences = import ./preferences.nix;
        };
      };

      profiles = {
        iain = import ./profiles/iain/default.nix {inherit pkgs;};
      };
    };
  };
}
