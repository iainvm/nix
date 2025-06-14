{...}: {
  imports = [
    ./nix

    ./applications/1password
    ./applications/fwupd
    ./applications/global-protect-vpn
    ./applications/steam
    ./applications/thunar

    ./display-managers/cosmic-greeter
    ./display-managers/ly
    ./display-managers/sddm

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

    ./users
  ];
}
