{
  # Specify profile-specific preferences here
  # Settings can be checked in 'about:config'

  # References:
  # - https://brainfucksec.github.io/firefox-hardening-guide
 
  # Captive Portal Check (disabled by package policies)
  # Telemetry (disabled by package policies)
  # Studies (disabled by package policies)
  # Firefox Accounts (disabled by package policies)

  # Language
  "intl.locale.requested" = "en-GB";
  "intl.regional_prefs.use_os_locales" = true;

  # Silence Warnings
  "browser.aboutConfig.showWarning" = false;

  # Disable features
  "browser.aboutwelcome.enabled" = false;
  "extensions.pocket.enabled" = false; # Disable Pocket a feature to save webpages
  "extensions.screenshots.disabled" = true;

  # Tracking
  "privacy.resistFingerprinting" = true;

  # New Tab Page
  "browser.startup.page" = 3; # On startup restore previous session
  "browser.startup.homepage" = "about:home";
  "browser.startup.couldRestoreSession.count" = 2;
  "browser.newtabpage.activity-stream.showSponsored" = false;
  "browser.newtabpage.activity-stream.feeds.snippets" = false;
  "browser.newtabpage.activity-stream.system.showSponsored" = false;
  "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
  "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
  "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
  "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
  "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
  "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
  "browser.topsites.contile.enabled" = false;

  # Auto Updates
  "app.update.auto" = false;
  "app.update.background.scheduling.enabled" = false;

  # Extensions
  "extensions.getAddons.showPane" = false;
  "extensions.htmlaboutaddons.recommendations.enabled" = false;

  # Disable password and form autofill
  "signon.autofillForms" = false;
  "signon.rememberSignons" = false;
  "signon.formlessCapture.enabled" = false;
  "network.auth.subresource-http-auth-allow" = 1;
  # "browser.formfill.enable" = false;

  # Search Suggestions
  "browser.search.suggest.enabled" = false;
  "browser.search.suggest.enabled.private" = false;
  "browser.urlbar.suggest.searches" = false;
  "browser.fixup.alternate.enabled" = false;
  "browser.urlbar.trimURLs" = false;
  "browser.urlbar.speculativeConnect.enabled" = false;
  "browser.urlbar.quicksuggest.scenario" = "history";
  "browser.urlbar.quicksuggest.enabled" = false;
  "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
  "browser.urlbar.suggest.quicksuggest.sponsored" = false;
  "browser.urlbar.showSearchSuggestionsFirst" = false;

  # Stop Popups
  "dom.disable_open_during_load" = true;

  # Styling
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Allows userChrome.css
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
        "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
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
      "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
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
}
