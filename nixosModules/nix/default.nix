{
  lib,
  config,
  ...
}: {
  options.core.nix.flakes = {
    enable = lib.mkEnableOption "enable nix flakes";
  };

  config = lib.mkIf config.core.nix.flakes.enable {
    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 10d";
      };

      settings.experimental-features = ["nix-command" "flakes"];
    };
  };
}
