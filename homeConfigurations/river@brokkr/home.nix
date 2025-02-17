{
  inputs,
  system,
  ...
}: let
  user = "river";
  name = "Iain";
  fullName = "Iain Majer";
  email = "iain.majer@river-island.com";
in {
  home.stateVersion = "24.11";
  home.username = user;
  home.homeDirectory = "/home/${user}";
  programs.home-manager.enable = true;

  imports = [
    inputs.self.homeModules.default
  ];

  # Environment Variables
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
  };

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

  network = {
    ri-vpn.enable = true;
  };

  fonts = {
    nerd-fonts.enable = true;
  };

  applications = {
    anytype.enable = true;
    capacities.enable = true;
    datagrip.enable = true;
    firefox.enable = true;
    kitty.enable = true;
    protonme = {
      pass.enable = true;
      desktop.enable = true;
    };
    stremio.enable = true;
    swappy.enable = true;
    teams.enable = true;
    vscode.enable = true;
    wofi.enable = true;
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
  };
}
