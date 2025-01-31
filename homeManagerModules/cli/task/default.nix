{
  lib,
  pkgs,
  config,
  ...
}: let
  name = "task";
  pname = "go-task";
  version = "3.40.1";

  src = pkgs.fetchFromGitHub {
    owner = "go-task";
    repo = "task";
    rev = "refs/tags/v${version}";
    hash = "sha256-jQKPTKEzTfzqPlNlKFMduaAhvDsogRv3vCGtZ4KP/O4=";
  };

  package = pkgs.buildGoModule rec {
    inherit src pname version;

    vendorHash = "sha256-bw9NaJOMMKcKth0hRqNq8mqib/5zLpjComo0oj22A/U=";

    doCheck = false;

    nativeBuildInputs = [pkgs.installShellFiles];

    subPackages = ["cmd/task"];

    ldflags = [
      "-s"
      "-w"
      "-X=github.com/go-task/task/v3/internal/version.version=${version}"
    ];

    env.CGO_ENABLED = 0;

    postInstall = ''
      installShellCompletion --cmd ${name} \
        --bash <($out/bin/${name} --completion bash) \
        --fish <($out/bin/${name} --completion fish) \
        --zsh <($out/bin/${name} --completion zsh)
    '';

    passthru = {
      tests = {
        version = pkgs.testers.testVersion {
          inherit package version;
          command = "${name} --version";
        };
      };

      updateScript = pkgs.nix-update-script {};
    };

    meta = with lib; {
      homepage = "https://taskfile.dev/";
      description = "Task runner / simpler Make alternative written in Go";
      changelog = "https://github.com/go-task/task/blob/v${version}/CHANGELOG.md";
      license = licenses.mit;
      maintainers = with maintainers; [parasrah];
    };
  };
in {
  options.cli.task = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the task package.";
    };
  };

  config = lib.mkIf config.cli.task.enable {
    home.packages = [package];
  };
}
