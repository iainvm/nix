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

  # System Configurations
  hyprland.enable = true;

  # Dotfiles
  home.file = {
    ".config" = {
      source = ./dotfiles;
      target = ".config/";
      recursive = true;
    };
  };

  # Shell
  fish = {
    enable = true;
    starship = {
      enable = true;
      transientPrompt = true;
    };
  };

  # CLI
  git = {
    enable = true;
    name = fullName;
    email = email;
  };
  direnv.enable = true;
  dpm.enable = true;
}
