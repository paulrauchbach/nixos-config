{ ... }:

{
  programs.firefox = {
    languagePacks = [ "de" ];
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      search.default = "ddg";
      search.force = true;

      settings = {
        "browser.startup.page" = 3;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.sessionstore.resume_from_crash" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        "browser.translations.neverTranslateLanguages" = "de,en";
        "browser.tabs.warnOnClose" = false;
        "browser.bookmarks.addedImportButton" = false;
        "identity.fxaccounts.enabled" = false;
        "spellchecker.dictionary" = "de-DE,en-US";
        "browser.search.suggest.enabled" = true;
        "browser.urlbar.suggest.searches" = true;
        "extensions.autoDisableScopes" = 0;
        "signon.rememberSignons" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.available" = "off";
      };

      userChrome = ''
        #nav-bar {
          min-height: 36px !important;
        }

        #sidebar-button {
          order: 10 !important;
        }

        #back-button {
          order: 20 !important;
        }

        #forward-button {
          order: 30 !important;
        }

        #stop-reload-button {
          order: 40 !important;
        }

        #vertical-spacer {
          display: none !important;
        }

        #urlbar-container {
          order: 50 !important;
          flex: 1 1 auto !important;
        }
      '';


      bookmarks = {
        force = true;
        settings = [
          {
            name = "Jura";
            toolbar = true;
            bookmarks = [ ];
          }
          {
            name = "Programmieren";
            toolbar = true;
            bookmarks = [
              {
                name = "NixOS Manual";
                url = "https://nixos.org/manual/nixos/stable/";
              }
              {
                name = "Home Manager Manual";
                url = "https://nix-community.github.io/home-manager/";
              }
              {
                name = "NixOS Search";
                url = "https://search.nixos.org/options";
              }
            ];
          }
          {
            name = "Informatik";
            toolbar = true;
            bookmarks = [ ];
          }
        ];
      };
    };

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableProfileImport = true;

      DisplayBookmarksToolbar = "always";
      SearchSuggestEnabled = true;

      Extensions = {
        Install = [
          "https://addons.mozilla.org/firefox/downloads/latest/dictionary-german/latest.xpi"
        ];
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          default_area = "navbar";
          private_browsing = true;
        };
      };

      FirefoxHome = {
        Search = true;
        TopSites = false;
        Highlights = false;
        Pocket = false;
        Stories = false;
        SponsoredTopSites = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        Snippets = false;
        Locked = true;
      };

      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };

      GenerativeAI = {
        Enabled = false;
        Chatbot = false;
        LinkPreviews = false;
        TabGroups = false;
        Locked = true;
      };

      TranslateEnabled = false;
      VisualSearchEnabled = false;

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = false;
        Locked = true;
      };
    };
  };
}
