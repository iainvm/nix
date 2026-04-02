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

  system = {
    dunst.enable = true;
    hyprland = {
      enable = true;
      settings = import ./files/hyprland/hyprland.nix;
    };
  };

  fonts = {
    nerd-fonts.enable = true;
  };

  applications = {
    anytype.enable = false;
    capacities.enable = false;
    discord.enable = true;
    firefox.enable = true;
    kitty.enable = true;
    prism.enable = true;
    protonme = {
      pass.enable = true;
      desktop.enable = true;
    };
    stremio.enable = false;
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
