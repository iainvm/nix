{
  system,
  inputs,
  ...
}: let
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in {
  default = pkgs.mkShell {
    packages = with pkgs; [
      # Git
      git

      # Nix LSP
      nixd
      # Nix Formatter
      alejandra

      # Taskfile
      go-task
    ];
  };
}
