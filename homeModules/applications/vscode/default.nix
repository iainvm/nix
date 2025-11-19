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
    extensions = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Additional extensions to install";
    };
  };

  config = lib.mkIf config.applications.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = true;

      profiles = {
        default = {
          userSettings = lib.mkMerge [
            (lib.importJSON defaultSettingsFile)
            (config.applications.vscode.settings)
          ];

          extensions = with pkgs.open-vsx;
            [
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
              eamodio.gitlens
            ]
            ++ config.applications.vscode.extensions;

          keybindings = lib.mkMerge [
            (lib.importJSON defaultKeybindingsFile)
            (config.applications.vscode.keybindings)
          ];
        };
      };
    };

    home.file.".vscode-oss/argv.json".text = builtins.toJSON {
      enable-crash-reporter = false;
      password-store = "gnome-libsecret";
    };
  };
}
