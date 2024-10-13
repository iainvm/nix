{self, ...}: {
  imports = [
    ./applications/vscode-server.nix
    ./shells/zsh.nix
    ./cli/direnv.nix
    ./cli/git.nix
  ];
}
