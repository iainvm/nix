{
  lib,
  pkgs,
  config,
  ...
}: let
  # Wrapping to scope the TMP files, since if multiple users install the `/tmp/go-graphviz` collides with user permissions
  wrapped = pkgs.writeShellScriptBin "anytype" ''
    TMP="/tmp/$USER-anytype" TMPDIR="/tmp/$USER-anytype" ${pkgs.anytype}/bin/anytype
  '';
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
