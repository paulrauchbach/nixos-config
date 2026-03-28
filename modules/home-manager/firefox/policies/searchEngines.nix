{ pkgs }:

let
  nixIcon = "file://${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
in
{
  Default = "DuckDuckGo";

  Add = [
    {
      Name = "Nix Packages";
      URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
      Method = "GET";
      IconURL = nixIcon;
      Alias = "@np";
      Description = "Search Nix packages";
    }
    {
      Name = "Nix Options";
      URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
      Method = "GET";
      IconURL = nixIcon;
      Alias = "@no";
      Description = "Search NixOS options";
    }
    {
      Name = "NixOS Wiki";
      URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
      Method = "GET";
      IconURL = nixIcon;
      Alias = "@nw";
      Description = "Search the NixOS Wiki";
    }
    {
      Name = "Home Manager";
      URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
      Method = "GET";
      IconURL = nixIcon;
      Alias = "@hm";
      Description = "Search Home Manager options";
    }
  ];

  Remove = [
    "Google"
    "Bing"
    "Amazon.com"
    "eBay"
  ];
}
