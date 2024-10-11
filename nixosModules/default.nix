{self, ...}: {
  imports = [
    ./cli/nix-flakes.nix
    ./hardware/bluetooth.nix
    ./hardware/network.nix
    ./language/en-gb.nix
    ./shells/zsh.nix
    ./users/simple-users.nix
  ];
}
