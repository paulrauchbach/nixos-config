{
  force = true;
  settings = [
    {
      name = "Bookmarks Toolbar";
      toolbar = true;
      bookmarks = [
        {
          name = "Development";
          bookmarks = [
            {
              name = "GitHub";
              tags = [ "code" "git" ];
              url = "https://github.com/";
            }
            {
              name = "MDN Web Docs";
              tags = [ "web" "docs" ];
              url = "https://developer.mozilla.org/";
            }
            {
              name = "DevDocs";
              tags = [ "docs" "reference" ];
              url = "https://devdocs.io/";
            }
            {
              name = "NixOS Search";
              tags = [ "nix" "packages" "options" ];
              url = "https://search.nixos.org/";
            }
            {
              name = "Home Manager Options";
              tags = [ "nix" "home-manager" ];
              url = "https://home-manager-options.extranix.com/";
            }
            {
              name = "NixOS Wiki";
              tags = [ "nix" "wiki" ];
              url = "https://wiki.nixos.org/";
            }
          ];
        }
        {
          name = "Chess";
          bookmarks = [
            {
              name = "Lichess";
              tags = [ "chess" "play" ];
              url = "https://lichess.org/";
            }
            {
              name = "Chess.com";
              tags = [ "chess" "play" ];
              url = "https://www.chess.com/";
            }
            {
              name = "Lichess Analysis Board";
              tags = [ "chess" "analysis" ];
              url = "https://lichess.org/analysis";
            }
            {
              name = "Lichess Opening Explorer";
              tags = [ "chess" "openings" ];
              url = "https://lichess.org/analysis#explorer";
            }
            {
              name = "Chess Tempo";
              tags = [ "chess" "tactics" ];
              url = "https://chesstempo.com/";
            }
            {
              name = "Lichess Studies";
              tags = [ "chess" "study" ];
              url = "https://lichess.org/study";
            }
          ];
        }
        {
          name = "Jura";
          bookmarks = [
            {
              name = "Gesetze im Internet";
              tags = [ "law" "de" "statutes" ];
              url = "https://www.gesetze-im-internet.de/";
            }
            {
              name = "dejure.org";
              tags = [ "law" "de" "cases" ];
              url = "https://dejure.org/";
            }
            {
              name = "openJur";
              tags = [ "law" "de" "judgments" ];
              url = "https://openjur.de/";
            }
            {
              name = "Bundesverfassungsgericht";
              tags = [ "law" "de" "court" ];
              url = "https://www.bundesverfassungsgericht.de/";
            }
            {
              name = "EUR-Lex";
              tags = [ "law" "eu" ];
              url = "https://eur-lex.europa.eu/";
            }
            {
              name = "Bundesgerichtshof";
              tags = [ "law" "de" "court" ];
              url = "https://www.bundesgerichtshof.de/";
            }
          ];
        }
      ];
    }
  ];
}
