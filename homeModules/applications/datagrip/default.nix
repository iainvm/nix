{
  lib,
  pkgs,
  config,
  ...
}: let
  pkgs_datagrip =
    import (pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "d482e00d611047d015838c8f308d5dfda9eb5e77";
      sha256 = "sha256-ayy4URxLWs7WvunUT0Nj+NGIqgMvTW3J/lTgSVhj4+c=";
    }) {
      inherit (pkgs) system;
      config.allowUnfree = true;
    };
in {
  options.applications.datagrip = {
    enable = lib.mkEnableOption "datagrip";
  };

  config = lib.mkIf config.applications.datagrip.enable {
    home.packages = with pkgs_datagrip; [
      jetbrains.datagrip
    ];
  };
}
