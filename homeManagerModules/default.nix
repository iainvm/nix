{self, ...}: {
  imports = [
    ./cli/direnv.nix
    ./cli/dpm.nix
    ./cli/git.nix
    ./shells/zsh.nix
  ];
}
