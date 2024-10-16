{
  lib,
  pkgs,
  config,
  ...
}: let
  dpm = pkgs.buildGoModule rec {
    pname = "dpm";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "iainvm";
      repo = "dpm";
      rev = "main";
      sha256 = "sha256-9xpscgu/tHyvStJpqlHx31Nn4Gqj7wRLCNDOQQd8nIM="; # Replace with the actual sha256 hash
    };
    vendorHash = "sha256-kV98peQAzCmRaVyMgotoyNNjU74dZKPpMU8wKvXd8bU=";
  };
in {
  options.dpm.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable the dpm package.";
  };

  config = lib.mkIf config.dpm.enable {
    home.packages = [dpm];
  };
}
