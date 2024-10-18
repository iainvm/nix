{pkgs, ...}: {
  # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
  id = 0; # 0 is the default profile; see also option "isDefault"
  name = "iain"; # name as listed in about:profiles
  isDefault = true; # can be omitted; true if profile ID is 0

  userChrome = builtins.readFile ./userChrome.css;
  search = import ./search-engines.nix {inherit pkgs;};

  settings = {
    # specify profile-specific preferences here; check about:config for options
    "browser.aboutConfig.showWarning" = false;
    "browser.aboutwelcome.enabled" = false;
    # "browser.startup.couldRestoreSession.count" = 2;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Allows userChrome.css
    "browser.startup.page" = 3; # On startup restore previous session
    "browser.toolbars.bookmarks.visibility" = "never"; # Don't show bookmark bar, even on new tabs
    "findbar.highlightAll" = true; # When finding always highlight all occurances
    "sidebar.position_start" = false; # Sidebery on right hand side

    # Top bar layout
    "browser.uiCustomization.state" = builtins.toJSON {
      placements = {
        widget-overflow-fixed-list = [];
        unified-extensions-area = [
          "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
          "_3c078156-979c-498b-8990-85f7987dd929_-browser-action"
        ];
        nav-bar = [
          "back-button"
          "forward-button"
          "stop-reload-button"
          "urlbar-container"
          "save-to-pocket-button"
          "downloads-button"

          # Extensions
          "ublock0_raymondhill_net-browser-action"
          "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
          "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
          "unified-extensions-button"

          "fxa-toolbar-menu-button"
        ];
        toolbar-menubar = ["menubar-items"];
        TabsToolbar = [
          "tabbrowser-tabs"
          "new-tab-button"
          "alltabs-button"
        ];
        PersonalToolbar = [
          "import-button"
          "personal-bookmarks"
        ];
      };
      seen = [
        "developer-button"
        "ublock0_raymondhill_net-browser-action"
        "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
        "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
        "_3c078156-979c-498b-8990-85f7987dd929_-browser-action"
        "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
      ];
      dirtyAreaCache = [
        "nav-bar"
        "toolbar-menubar"
        "TabsToolbar"
        "PersonalToolbar"
        "unified-extensions-area"
      ];
      currentVersion = 20;
      newElementCount = 5;
    };
  };
}
