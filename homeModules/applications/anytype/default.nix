{
  lib,
  pkgs,
  config,
  ...
}: let
  # Wrap the binary to ensure different users have different tmp files
  # Without this I was having problems with `tmp/go-graphviz` and 1 user owning the folder
  wrapped = pkgs.symlinkJoin {
    name = "anytype";
    paths = [pkgs.anytype];
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
