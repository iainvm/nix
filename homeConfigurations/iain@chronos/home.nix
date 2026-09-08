{
  lib,
  inputs,
  ...
}: let
  user = "iain";
  fullName = "Iain Majer";
  email = "iainvm@outlook.com";
in {
  home.stateVersion = "24.11";
  home.username = user;
  home.homeDirectory = "/home/${user}";
  applications.stylix.enable = true;

  imports = [
    inputs.self.homeModules.default
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/${user}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.yaml;
    secrets = {
      "chronos/users/iain/ssh_key" = {
        path = "/home/${user}/.ssh/id_ed25519";
      };
    };
  };

  system = {
    dunst.enable = true;
    hyprland = {
      enable = true;
      settings = ./files/hyprland/hyprland.lua;
    };
  };

  fonts = {
    nerd-fonts.enable = true;
  };

  shared = {
    dictionary.enable = true;
  };

  applications = {
    anytype.enable = false;
    capacities.enable = false;
    discord.enable = true;
    gram.enable = true;
    kitty.enable = true;
    obsidian.enable = true;
    prism.enable = true;
    protonme = {
      pass.enable = true;
      desktop.enable = true;
      vpn.enable = true;
    };
    swappy.enable = true;
    vintagestory.enable = true;
    vlc.enable = true;
    wofi.enable = true;
    firefox.enable = true;
    zen.enable = true;

    vscode = {
      enable = true;
      settings = lib.importJSON ./files/vscode/settings.json;
    };
  };

  cli = {
    git = {
      enable = true;
      name = fullName;
      email = email;
    };
    direnv.enable = true;
    dpm.enable = true;
    task.enable = true;
    zsh.enable = true;
  };
}
