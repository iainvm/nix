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
      sha256 = "sha256-9xpscgu/tHyvStJpqlHx31Nn4Gqj7wRLCNDOQQd8nIM=";
    };
    vendorHash = "sha256-kV98peQAzCmRaVyMgotoyNNjU74dZKPpMU8wKvXd8bU=";
    nativeBuildInputs = [ pkgs.installShellFiles ];
    postInstall = ''
    installShellCompletion --cmd dpm \
      --bash <($out/bin/dpm completion bash) \
      --fish <($out/bin/dpm completion fish) \
      --zsh <($out/bin/dpm completion zsh)
    '';
  };
in {
  options.cli.dpm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the dpm package.";
    };
  };

  config = lib.mkIf config.cli.dpm.enable {
    home.packages = [dpm];
  };
}
