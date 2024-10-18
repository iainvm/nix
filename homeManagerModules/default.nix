{self, ...}: {
  imports = [
    ./cli/direnv.nix
    ./cli/dpm.nix
    ./cli/git.nix
    ./shells/fish
    ./shells/zsh
    ./window-manager/hyprland
  ];
}
