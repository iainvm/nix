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
      languagePacks = ["en-GB"];
      configPath = ".mozilla/firefox"; # Old default config location

      policies = {
        # https://mozilla.github.io/policy-templates/
        CaptivePortal = false;
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisableFirefoxAccounts = true;
        DontCheckDefaultBrowser = true;
        UserMessaging = {
          FirefoxLabs = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
          FeatureRecommendations = false;
          ExtensionRecommendations = false;
        };
      };

      profiles = {
        iain = import ./profiles/iain/default.nix {inherit pkgs;};
      };
    };
  };
}
