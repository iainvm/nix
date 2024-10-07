{...}: {
  home.stateVersion = "24.05";
  home.username = "iain";
  home.homeDirectory = "/home/iain";
  programs.home-manager.enable = true;



  programs.direnv = {
    enable = true;

    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };

  programs = {
    # Main Terminal
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
    };
  };
}
