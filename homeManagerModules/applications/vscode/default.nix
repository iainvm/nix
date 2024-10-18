{
  lib,
  config,
  nixpkgs,
  ...
}: {
  options.applications.vscode = {
    enable = lib.mkEnableOption "enable vscode";
  };

  config = lib.mkIf config.applications.vscode.enable {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "vscode"
      ];

    programs.vscode = {
      enable = true;
    };
  };
}
