{
  lib,
  pkgs,
  config,
  system,
  inputs,
  ...
}: let
  # zen-browser = inputs.zen-browser.packages."${system}".zen-browser-unwrapped;
  zen-browser = inputs.zen-browser.packages."${system}".default;
in {
  options.applications.zen = {
    enable = lib.mkEnableOption "enable zen";
  };

  config = lib.mkIf config.applications.zen.enable {
    xdg.mimeApps.defaultApplications = {
      "text/html" = ["zen.desktop"];
      "x-scheme-handler/http" = ["zen.desktop"];
      "x-scheme-handler/https" = ["zen.desktop"];
      "x-scheme-handler/about" = ["zen.desktop"];
      "x-scheme-handler/unknown" = ["zen.desktop"];
    };
    home.packages = [
      zen-browser
    ];

    # programs.firefox = {
    #   enable = true;
    #   package = pkgs.wrapFirefox zen-browser {};
    #   languagePacks = ["en-GB"];
    #   configPath = ".zen";

    #   policies = {
    #     # https://mozilla.github.io/policy-templates/
    #     DontCheckDefaultBrowser = true;
    #     PasswordManagerEnabled = false;
    #     DisableAppUpdate = true;
    #   };

    #   # profiles = {
    #   #   iain = import ./profiles/iain/default.nix {inherit pkgs;};
    #   # };
    # };
  };
}
