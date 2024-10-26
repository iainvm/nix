{self, ...}: {
  imports = [
    ./nix
    ./applications/1password
    ./applications/thunar
    ./applications/vscode-server
    ./hardware/bluetooth
    ./hardware/network
    ./hardware/nvidia
    ./hardware/sound
    ./shells/zsh.nix
    ./system/hyprland
    ./system/language
    ./system/plymouth
    ./system/sddm
    ./users
  ];
}
