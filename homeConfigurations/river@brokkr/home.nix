{
  lib,
  pkgs,
  inputs,
  ...
}: let
  user = "river";
  fullName = "Iain Majer";
  email = "iain.majer@river-island.com";
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
    # I want to manage this in the dotfiles
    # Would need to use `--impure` to execute the `flake.nix` cause it's a symlink
    # "dev/github.com/River-Island" = {
    #   source = ./files/ri-direnv;
    #   target = "dev/github.com/River-Island/";
    #   recursive = true;
    # };
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

  shared = {
    dictionary.enable = true;
  };

  applications = {
    anytype.enable = true;
    capacities.enable = false;
    discord.enable = true;
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
    wofi.enable = true;

    vscode = {
      enable = true;
      settings = lib.importJSON ./files/vscode/settings.json;
      # keybindings = lib.importJSON ./files/vscode/keybindings.json;
      extensions = with pkgs.open-vsx; [
        nicolasvuillamy.vscode-groovy-lint
        saoudrizwan.claude-dev
      ];
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
  };
}
