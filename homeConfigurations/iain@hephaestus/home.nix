{inputs, ...}: let
  user = "iain";
  fullName = "Iain Majer";
  email = "iainvm@outlook.com";
in {
  imports = [
    inputs.self.homeModules.default
  ];

  # Dotfiles
  home.file = {
    ".config" = {
      source = ./dotfiles;
      target = ".config/";
      recursive = true;
    };
  };

  home.stateVersion = "24.11";
  home.username = user;
  home.homeDirectory = "/home/${user}";
  applications.stylix.enable = true;

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
    discord.enable = true;
    firefox.enable = true;
    kitty.enable = true;
    obsidian.enable = true;
    prism.enable = true;
    protonme = {
      pass.enable = true;
      desktop.enable = true;
      vpn.enable = true;
    };
    swappy.enable = true;
    wofi.enable = true;
    vscode = {
      enable = true;
    };
  };

  shells.zsh = {
    enable = true;
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
  };
}
