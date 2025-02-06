{self, ...}: {
  imports = [
    ./nix

    ./applications/1password
    ./applications/global-protect-vpn
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
    ./system/ly
    ./system/plymouth
    ./system/sddm

    ./users
  ];
}
