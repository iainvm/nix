{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.vscode-server.nixosModules.default
  ];

  options.vscode-server = {
    enable = lib.mkEnableOption "enable vscode-server";
  };

  config = lib.mkIf config.vscode-server.enable {
    services.vscode-server.enable = true;
  };
}
