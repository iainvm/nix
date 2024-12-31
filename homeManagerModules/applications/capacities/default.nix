{
  lib,
  pkgs,
  config,
  ...
}: let
  pname = "capacities";
  version = "1.44.13";
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://capacities-desktop-app.fra1.cdn.digitaloceanspaces.com/Capacities-${version}.AppImage";
    sha256 = "sha256-f1nfINXqMt1SVZMJlrrAmsB3CqvY/AYDuYBVKNWOkSM=";
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit pname version src; };
  capacities = pkgs.appimageTools.wrapType2 {
    inherit src pname version;

    nativeBuildInputs = [ pkgs.makeWrapper ];

    extraInstallCommands = ''
      wrapProgram $out/bin/${pname} \
          --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}"

      install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${appimageContents}/usr/share/icons $out/share
    '';

    meta = {
      description = "Calm place to make sense of the world and create amazing things";
      homepage = "https://capacities.io/";
      platforms = [ "x86_64-linux" ];
      sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
      license = lib.licenses.unfree;
      mainProgram = "capacities";
    };
  };
in
{
  options.applications.capacities = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the capacities package.";
    };
  };

  config = lib.mkIf config.applications.capacities.enable {
    home.packages = [capacities];
  };
}
