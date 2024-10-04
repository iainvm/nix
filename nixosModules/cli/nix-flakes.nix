{
  lib,
  config,
  ...
}: {
  options = {
    nix-flakes.enable = lib.mkEnableOption "enable nix flakes";
  };

  config = lib.mkIf config.nix-flakes.enable {
    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 10d";
      };

      settings.experimental-features = ["nix-command" "flakes"];
    };
  };
}
