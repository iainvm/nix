{
  lib,
  pkgs,
  inputs,
  ...
}: let
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

  shells = import ./shell.nix {inherit pkgs lib;};

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
