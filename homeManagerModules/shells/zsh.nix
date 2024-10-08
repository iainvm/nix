{
  lib,
  config,
  ...
}: {
  options.zsh = {
    enable = lib.mkEnableOption "enable zsh";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
    };
  };
}
