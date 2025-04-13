{pkgs, ...}: let
  hidden = {
    metaData.hidden = true;
  };
in {
  force = true;
  default = "Kagi";

  engines = {
    "bing" = hidden;
    "ebay" = hidden;
    "google" = hidden;
    "ddg" = hidden;
    "wikipedia" = hidden;

    "Kagi" = {
      urls = [
        {
          template = "https://kagi.com/search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      icon = "${pkgs.fetchurl {
        url = "https://assets.kagi.com/v2/favicon-32x32.png";
        hash = "sha256-1FiWp2i1Qm/EEOLzoOV0GfAF81b84xFp2ExdaAfG5x8=";
      }}";

      definedAliases = ["@k"];
    };

    "GitHub" = {
      urls = [
        {
          template = "https://github.com/search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      icon = "${pkgs.fetchurl {
        url = "https://github.githubassets.com/favicons/favicon.svg";
        hash = "sha256-apV3zU9/prdb3hAlr4W5ROndE4g3O1XMum6fgKwurmA=";
      }}";

      definedAliases = ["@gh"];
    };

    "Nix Packages" = {
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "channel";
              value = "unstable";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@np"];
    };

    "Home Manager" = {
      urls = [
        {
          template = "https://home-manager-options.extranix.com";
          params = [
            {
              name = "channel";
              value = "unstable";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      icon = "${pkgs.fetchurl {
        url = "https://home-manager-options.extranix.com/images/favicon.png";
        hash = "sha256-oFp+eoTLXd0GAK/VrYRUeoXntJDfTu6VnzisEt+bW74=";
      }}";
      definedAliases = ["@hm"];
    };

    "Youtube" = {
      urls = [
        {
          template = "https://www.youtube.com/results";
          params = [
            {
              name = "search_query";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      icon = "${pkgs.fetchurl {
        url = "https://www.youtube.com/s/desktop/8498231a/img/favicon_144x144.png";
        hash = "sha256-lQ5gbLyoWCH7cgoYcy+WlFDjHGbxwB8Xz0G7AZnr9vI=";
      }}";

      definedAliases = ["@y"];
    };
  };
}
