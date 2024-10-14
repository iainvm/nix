{self, ...}: {
  imports = [
    ./shells/zsh.nix
    ./cli/direnv.nix
    ./cli/git.nix
  ];
}
