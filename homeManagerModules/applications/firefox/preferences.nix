let
  lock = {value}: {
    Value = value;
    Status = "locked";
  };
in {
  "browser.shell.checkDefaultBrowser" = lock {value = false;};
  "browser.contentblocking.category" = lock {value = "strict";};
  "extensions.pocket.enabled" = lock {value = false;};
  "extensions.screenshots.disabled" = lock {value = true;};
  "browser.topsites.contile.enabled" = lock {value = false;};
  # "browser.formfill.enable" = lock {value = false; };
  "browser.search.suggest.enabled" = lock {value = false;};
  "browser.search.suggest.enabled.private" = lock {value = false;};
  "browser.urlbar.suggest.searches" = lock {value = false;};
  "browser.urlbar.showSearchSuggestionsFirst" = lock {value = false;};
  "browser.newtabpage.activity-stream.feeds.section.topstories" = lock {value = false;};
  "browser.newtabpage.activity-stream.feeds.snippets" = lock {value = false;};
  "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock {value = false;};
  "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock {value = false;};
  "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock {value = false;};
  "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock {value = false;};
  "browser.newtabpage.activity-stream.showSponsored" = lock {value = false;};
  "browser.newtabpage.activity-stream.system.showSponsored" = lock {value = false;};
  "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock {value = false;};
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = lock {value = false;};
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = lock {value = false;};
  "intl.locale.requested" = lock {value = "en-GB";};
  "intl.regional_prefs.use_os_locales" = lock {value = true;};
}
