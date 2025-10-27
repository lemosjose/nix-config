{ pkgs, inputs, config, lib, ... }:

let
lock-false = {
  Value = false;
  status = "locked"; 
};

lock-true = {
  Value = true;
  status = "locked";
};

in {

programs.firefox = {
  enable = true;

  policies = {
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    DontCheckDefaultBrowser = true;
    DisablePocket = true;
  };

  profiles.default = {
    isDefault = true;

    extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
      ublock-origin
      darkreader
      search-by-image
      dearrow
      old-reddit-redirect
      privacy-badger
    ];
    # >:) 
    extensions.force = true;

    settings = {
      "sidebar.verticalTabs" = lock-true;

      "app.shield.optoutstudies.enabled" = lock-false;
      "app.normandy.enabled" = lock-false;
      "app.normandy.api_url" = "";

      "beacon.enabled" = lock-false;

      "browser.startup.homepage" = "https://news.ycombinator.com/";
      "browser.search.separatePrivateDefault.ui.enabled" = lock-true;
      "browser.urlbar.update2.engineAliasRefresh" = lock-true;
      "browser.search.suggest.enabled" = lock-false;
      "browser.urlbar.suggest.quicksuggest.sponsored" = lock-false;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = lock-false;
      "browser.formfill.enable" = lock-false;
      "browser.privatebrowsing.forceMediaMemoryCache" = lock-true;
      "browser.sessionstore.interval" = 60000;
      "browser.download.start_downloads_in_tmp_dir" = lock-true;
      "browser.helperApps.deleteTempFileOnExit" = lock-true;
      "browser.uitour.enabled" = lock-false;
      "browser.newtabpage.activity-stream.feeds.telemetry" = lock-false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      "browser.newtabpage.activity-stream.telemetry" = lock-false;
      "browser.newtabpage.activity-stream.feeds.topsites" = lock-false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
      "browser.ping-centre.telemetry" = lock-false;
      "browser.contentblocking.category" = "strict";
      "browser.download.animateNotifications" = lock-false;
      "browser.download.always_ask_before_handling_new_types" = lock-true;
      "browser.download.manager.addToRecentDocs" = lock-false;
      "browser.send_pings" = lock-false;
      "browser.sessionstore.privacy_level" = 2;
      "browser.safebrowsing.downloads.remote.enabled" = lock-false;
      "browser.pocket.enabled" = lock-false;
      "browser.xul.error_pages.expert_bad_cert" = lock-true;
      "browser.download.open_pdf_attachments_inline" = lock-true;
      "browser.bookmarks.openInTabClosesMenu" = lock-false;
      "browser.menu.showViewImageInfo" = lock-true;
      "browser.cache.jsbc_compression_level" = 3;

      "cookiebanners.service.mode" = 1;
      "cookiebanners.service.mode.privateBrowsing" = 1;

      "content.notify.interval" = 100000;

      "datareporting.policy.dataSubmissionEnabled" = lock-false;
      "datareporting.healthreport.uploadEnabled" = lock-false;

      "dom.enable_web_task_scheduling" = lock-true;
      "dom.event.clipboardevents.enabled" = lock-true;
      "dom.security.https_first" = lock-true;
      "dom.security.https_first_schemeless" = lock-true;
      "dom.security.sanitizer.enabled" = lock-true;

      "extensions.postDownloadThirdPartyPrompt" = lock-false;
      "extensions.pocket.enabled" = lock-false;

      "full-screen-api.transition-duration.enter" = "0 0";
      "full-screen-api.transition-duration.leave" = "0 0";
      "full-screen-api.warning.delay" = -1;
      "full-screen-api.warning.timeout" = 0;

      "fission.autostart" = lock-true;

      "findbar.highlightAll" = lock-true;

      "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";

      "gfx.canvas.accelerated.cache-items" = 4096;
      "gfx.canvas.accelerated.cache-size" = 512;
      "gfx.content.skia-font-cache-size" = 20;
      "gfx.webrender.all" = lock-true;

      "image.mem.decode_bytes_at_a_time" = 32768;

      "layout.css.grid-template-masonry-value.enabled" = lock-true;
      "layout.css.has-selector.enabled" = lock-true;
      "layout.word_select.eat_space_to_next_word" = lock-false;

      "loop.enabled" = lock-false;

      "media.memory_cache_max_size" = 65536;
      "media.cache_readahead_limit" = 7200;
      "media.cache_resume_threshold" = 3600;
      "media.navigator.enabled" = lock-false;
      "media.peerconnection.ice.proxy_only_if_behind_proxy" = lock-true;
      "media.peerconnection.ice.default_address_only" = lock-true;

      "network.cookie.cookiehardware-video-decoding,enabled" = lock-true;
      "network.IDN_show_punycode" = lock-true;
      "network.http.referer.XOriginTrimmingPolicy" = 2;
      "network.prefetch-next" = lock-false;
      "network.predictor.enabled" = lock-false;
      "network.cookie.sameSite.noneRequiresSecure" = lock-true;
      "network.http.max-connections" = 1800;
      "network.http.max-persistent-connections-per-server" = 10;
      "network.http.max-urgent-start-excessive-connections-per-host" = 5;
      "network.http.pacing.requests.enabled" = lock-false;
      "network.dns.disablePrefetch" = lock-true;
      "network.dnsCacheExpiration" = 3600;
      "network.dns.max_high_priority_threads" = 8;
      "network.ssl_tokens_cache_capacity" = 10240;

      "permissions.default.desktop-notification" = 2;
      "permissions.default.geo" = 2;
      "permissions.manager.defaultsUrl" = "";

      "pdfjs.enableScripting" = lock-false;

      "privacy.trackingprotection.fingerprinting.enable" = lock-true;
      "privacy.trackingprotection.cryptomining.enable" = lock-true;
      "privacy.trackingprotection.enable" = lock-true;
      "privacy.history.custom" = lock-true;
      "privacy.userContext.ui.enabled" = lock-true;

      "reader.parse-on-load.enabled" = lock-false;
      "reader.parse-on-load.force-enabled" = lock-false;

      "security.dialog_enable_delay" = lock-false;
      "security.OCSP.enabled" = 0;
      "security.remote_settings.crlite_filters.enabled" = lock-true;
      "security.pki.crlite_mode" = 2;
      "security.ssl.treat_unsafe_negotiation_as_broken" = lock-true;
      "security.tls.enable_0rtt_data" = lock-false;
      "security.insecure_connection_text.enabled" = lock-true;
      "security.insecure_connection_text.pbmode.enabled" = lock-true;
      "security.mixed_content.block_display_content" = lock-true;
      "security.mixed_content.upgrade_display_content" = lock-true;
      "security.mixed_content.upgrade_display_content.image" = lock-true;

      "toolkit.telemetry.archive.enabled" = lock-false;
      "toolkit.telemetry.bhrPing.enabled" = lock-false;
      "toolkit.telemetry.enabled" = lock-false;
      "toolkit.telemetry.server" = "data:,";
      "toolkit.telemetry.coverage.opt-out" = lock-true;
      "toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
      "toolkit.telemetry.hybridContent.enabled" = lock-false;
      "toolkit.telemetry.newProfilePing.enabled" = lock-false;
      "toolkit.telemetry.reportingpolicy.firstRun" = lock-false;
      "toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
      "toolkit.telemetry.unified" = lock-false;
      "toolkit.telemetry.updatePing.enabled" = lock-false;
      "toolkit.coverage.opt-out" = lock-true;
      "toolkit.coverage.endpoint.base" = "";

      "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
      "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";

      "webgl.disabled" = lock-false;

      "webchannel.allowObject.urlWhitelist" = "";

      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "widget.use-xdg-desktop-portal.mime-handler" = 1;
    };

  search.force = true;

  search.default = "ecosia";

  search.order = [ "ecosia" "ddg" ]; 

  search.engines = {
    "ecosia" = {
      definedAliases = ["@eco"];
      urls = [
        {
          template = "https://www.ecosia.org/search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];
    };
    "Nix Packages" = {
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      definedAliases = ["@np"];
    };
    "Nix Options" = {
      definedAliases = ["@no"];
      urls = [
        {
          template = "https://search.nixos.org/options";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
    };
  };

  
}; 
};
}
