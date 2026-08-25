{
  lib,
  config,
  ...
}: {
  options.core.nix.flakes = {
    enable = lib.mkEnableOption "enable nix flakes";
  };

  config = lib.mkIf config.core.nix.flakes.enable {

    # only 10 generations are kept
    boot.loader.systemd-boot.configurationLimit = 10;

    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 10d";
      };

      settings.experimental-features = ["nix-command" "flakes"];
    };
  };
}
