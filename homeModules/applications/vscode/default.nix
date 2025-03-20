{
  lib,
  pkgs,
  config,
  ...
}: let
  defaultSettingsFile = ./vscode-settings.json;
  defaultKeybindingsFile = ./vscode-keybindings.json;
in {
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
            (lib.importJSON defaultSettingsFile)
            (config.applications.vscode.settings)
          ];

          extensions = with pkgs.open-vsx; [
            jnoortheen.nix-ide
            mkhl.direnv
            bierner.markdown-mermaid
            golang.go
            qufiwefefwoyn.inline-sql-syntax
            streetsidesoftware.code-spell-checker
            timonwong.shellcheck
            redhat.vscode-yaml
            task.vscode-task
            takumii.markdowntable
            file-icons.file-icons
            nicolasvuillamy.vscode-groovy-lint
          ];

          keybindings = lib.mkMerge [
            (lib.importJSON defaultKeybindingsFile)
            (config.applications.vscode.keybindings)
          ];
        };
      };
    };
  };
}
