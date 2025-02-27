{
  lib,
  pkgs,
  config,
  ...
}: let
  pkgs_anytype = import (pkgs.fetchFromGitHub {
    owner = "TomaSajt";
    repo = "nixpkgs";
    rev = "anytype";
    sha256 = "sha256-a0Aawv0FXZvdQRsO4sPysrRArvJajtxKNdapZ29KAfU=";
  }) {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
  # Wrap the binary to ensure different users have different tmp files
  # Without this I was having problems with `tmp/go-graphviz` and 1 user owning the folder
  wrapped = pkgs.symlinkJoin {
    name = "anytype";
    paths = [pkgs_anytype.anytype];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/anytype --run 'export TMP="/tmp/$USER-anytype"' --run  'export TMPDIR="/tmp/$USER-anytype"'
    '';
  };
in {
  options.applications.anytype = {
    enable = lib.mkEnableOption "anytype";
  };

  config = lib.mkIf config.applications.anytype.enable {
    home.packages = [
      wrapped
    ];
  };
}
