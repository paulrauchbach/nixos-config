{ config, lib, pkgs, ... }:

let
  cfg = config.firefox;
  homeDir = config.home.homeDirectory;
  mozAddon = slug: "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
in
{
  options.firefox.enable = lib.mkEnableOption "Firefox";

  config = lib.mkIf cfg.enable {
    home.file.".mozilla/firefox/profiles.ini".force = true;

    programs.firefox = {
      enable = true;
      package = pkgs.firefox.override {
        nativeMessagingHosts = [ pkgs.gnome-browser-connector ];
      };

      languagePacks = [ "en-US" "de" ];
      policies = import ./policies/policies.nix {
        inherit homeDir mozAddon;
        preferences = import ./policies/preferences.nix;
        searchEngines = import ./policies/searchEngines.nix { inherit pkgs; };
      };

      profiles.default = {
        id = 0;
        isDefault = true;

        bookmarks = import ./bookmarks.nix;
      };
    };
  };
}
