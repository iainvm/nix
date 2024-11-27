{
  lib,
  config,
  ...
}: {
  options.core.zsh = {
    enable = lib.mkEnableOption "enable zsh";
  };

  config = lib.mkIf config.core.zsh.enable {
    programs.zsh = {
      enable = true;
    };
  };
}
