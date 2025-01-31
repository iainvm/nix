{self, ...}: {
  imports = [
    ./nix

    ./applications/1password
    ./applications/steam
    ./applications/thunar
    ./applications/vscode-server

    ./hardware/bluetooth
    ./hardware/network
    ./hardware/nvidia
    ./hardware/sound
    ./hardware/thunderbolt

    ./shells/zsh.nix

    ./system/hyprland
    ./system/keyring
    ./system/language
    ./system/plymouth
    ./system/sddm

    ./users
  ];
}
