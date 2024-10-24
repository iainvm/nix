{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.vscode = {
    enable = lib.mkEnableOption "enable vscode";
  };

  config = lib.mkIf config.applications.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
    };
  };
}
