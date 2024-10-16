{
  lib,
  config,
  ...
}: {
  options.zsh = {
    enable = lib.mkEnableOption "enable zsh";

    starship = {
      enable = lib.mkEnableOption "enable starship";
    };
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
    };

    programs.starship = lib.mkIf config.zsh.starship.enable {
      enable = true;
    };
  };
}
