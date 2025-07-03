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
  programs.home-manager.enable = true;
  applications.stylix.enable = true;

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

  system = {
    dunst.enable = true;
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
    kitty.enable = true;
    prism.enable = true;
    protonme = {
      pass.enable = true;
      desktop.enable = true;
    };
    stremio.enable = true;
    swappy.enable = true;
    vesktop.enable = true;
    wofi.enable = true;
    firefox.enable = true;
    zen.enable = true;

    vscode = {
      enable = true;
      settings = lib.importJSON ./files/vscode/settings.json;
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
