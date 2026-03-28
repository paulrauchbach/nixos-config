{ homeDir, mozAddon, preferences, searchEngines }:

{
  AppAutoUpdate = false;
  BackgroundAppUpdate = false;
  DefaultDownloadDirectory = "${homeDir}/Downloads";

  DisableFirefoxAccounts = true;
  DisableFirefoxScreenshots = true;
  DisableFirefoxStudies = true;
  DisableFeedbackCommands = true;
  DisablePocket = true;
  DisableProfileImport = true;
  DisableRemoteImprovements = true;
  DisableSetDesktopBackground = true;

  DisplayBookmarksToolbar = "always";
  DisplayMenuBar = "never";
  DontCheckDefaultBrowser = true;
  HardwareAcceleration = true;
  ManualAppUpdateOnly = true;
  OfferToSaveLogins = false;
  PasswordManagerEnabled = false;
  PromptForDownloadLocation = true;
  SearchSuggestEnabled = true;
  SkipTermsOfUse = true;
  TranslateEnabled = true;

  ExtensionSettings = {
    "uBlock0@raymondhill.net" = {
      install_url = mozAddon "ublock-origin";
      installation_mode = "force_installed";
      default_area = "navbar";
      private_browsing = true;
    };
  };

  FirefoxHome = {
    Search = true;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    SponsoredPocket = false;
    Stories = false;
    SponsoredStories = false;
    Snippets = false;
  };

  FirefoxSuggest = {
    WebSuggestions = false;
    SponsoredSuggestions = false;
    ImproveSuggestions = false;
    Locked = true;
  };

  GenerativeAI = {
    Enabled = false;
    Chatbot = false;
    LinkPreviews = false;
    TabGroups = false;
    Locked = true;
  };

  Homepage = {
    StartPage = "previous-session";
  };

  Preferences = builtins.mapAttrs (_: value: {
    Value = value;
    Status = "locked";
  }) preferences;
  SearchEngines = searchEngines;

  UserMessaging = {
    SkipOnboarding = true;
    UrlbarInterventions = false;
  };
}
