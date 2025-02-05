{
  lib,
  pkgs,
  ...
}: {
  zsh = {
    enable = true;
    starship = {
      enable = true;
      transientPrompt = true;
    };
  };
}
