{inputs, ...}: let
  user = "iain";
  fullName = "Iain Majer";
  email = "iainvm@outlook.com";
in {
  imports = [
    inputs.self.homeModules.default
  ];

  home.stateVersion = "24.11";
  home.username = user;
  home.homeDirectory = "/home/${user}";
  programs.home-manager.enable = true;

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

  applications = {
    anytype.enable = true;
    capacities.enable = false;
    discord.enable = true;
    firefox.enable = true;
    kitty.enable = true;
    prism.enable = true;
    protonme = {
      pass.enable = true;
      desktop.enable = true;
    };
    stremio.enable = true;
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
