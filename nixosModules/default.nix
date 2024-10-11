{self, ...}: {
  imports = [
    ./cli/nix-flakes.nix
    ./hardware/bluetooth.nix
    ./language/en-gb.nix
    ./users/simple-users.nix
  ];
}
