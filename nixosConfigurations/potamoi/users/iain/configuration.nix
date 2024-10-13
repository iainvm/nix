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

  # Applications
  vscode-server.enable = true;

  # Shell
  zsh.enable = true;

  # CLI
  git = {
    enable = true;
    name = fullName;
    email = email;
  };
  direnv.enable = true;
}
