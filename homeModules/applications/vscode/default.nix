{
  lib,
  pkgs,
  config,
  ...
}: {
  options.applications.vscode = {
    enable = lib.mkEnableOption "enable vscode";
    settings = lib.mkOption {
        type = lib.types.attrs;
        default = {};
        description = "Path to additional user settings";
    };
    keybindings = lib.mkOption {
        type = lib.types.listOf lib.types.attrs;
        default = [];
        description = "Path to additional keybindings";
    };
  };

  config = lib.mkIf config.applications.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      profiles = {
        default = {
          userSettings = lib.mkMerge [
            (lib.importJSON ./settings.json)
            (config.applications.vscode.settings)
          ];

          extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
            mkhl.direnv
            bierner.markdown-mermaid
            golang.go
          ];

          keybindings = lib.mkMerge [
            (lib.importJSON ./keybindings.json)
            (config.applications.vscode.keybindings)
          ];
        };
      };
    };
  };
}
