{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.vscode-server.nixosModules.default
  ];

  options.core.applications.vscode-server = {
    enable = lib.mkEnableOption "enable vscode-server";
  };

  config = lib.mkIf config.core.applications.vscode-server.enable {
    services.vscode-server.enable = true;
  };
}
