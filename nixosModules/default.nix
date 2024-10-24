{self, ...}: {
  imports = [
    ./applications/1password
    ./applications/thunar
    ./cli/nix-flakes.nix
    ./display-manager/sddm.nix
    ./hardware/bluetooth.nix
    ./hardware/network.nix
    ./hardware/nvidia.nix
    ./language/en-gb.nix
    ./services/vscode-server.nix
    ./shells/fish.nix
    ./shells/zsh.nix
    ./system/plymouth.nix
    ./system/sound
    ./users/simple-users.nix
    ./window-manager/hyprland.nix
  ];
}
