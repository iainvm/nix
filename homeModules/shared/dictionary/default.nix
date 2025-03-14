{
  lib,
  config,
  ...
}: {
  options.shared.dictionary = {
    enable = lib.mkEnableOption "dictionary";
  };

  config = lib.mkIf config.shared.dictionary.enable {
    home.file.".config/dictionary.txt".source = ./files/dictionary.txt;
  };
}
