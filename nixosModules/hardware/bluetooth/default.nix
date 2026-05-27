{
  lib,
  config,
  ...
}: {
  options.core.hardware.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf config.core.hardware.bluetooth.enable {
    hardware.bluetooth = {
      # bluetoothctl cli is broken:
      # Waiting for
      # https://github.com/NixOS/nixpkgs/blob/staging/pkgs/by-name/bl/blueman/package.nix
      # to end up of nixos-unstable
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
    services.blueman = {
      enable = true;
    };
  };
}
