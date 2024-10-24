{inputs, ...}: let
  user = "iain";
  name = "Iain";
  fullName = "Iain Majer";
  email = "iainvm@outlook.com";
in {
  home.stateVersion = "24.05";
  home.username = user;
  home.homeDirectory = "/home/${user}";
  programs.home-manager.enable = true;

  imports = [
    inputs.self.homeManagerModules.default
  ];

  # Dotfiles
  home.file = {
    ".config" = {
      source = ./dotfiles;
      target = ".config/";
      recursive = true;
    };
  };

  # system = {
  #   hyprland.enable = true;
  # };

  fonts = {
    nerd-fonts.enable = true;
  };

  applications = {
    firefox.enable = true;
    kitty.enable = true;
    vscode.enable = true;
    wofi.enable = true;
  };

  shells.zsh.enable = true;

  cli = {
    git = {
      enable = true;
      name = fullName;
      email = email;
    };
    direnv.enable = true;
    dpm.enable = true;
  };
}
