{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  zshModule = import "${inputs.home-manager}/modules/programs/zsh.nix" {inherit pkgs lib config;};
in {
  options.shells.zsh = {
    enable = lib.mkEnableOption "enable zsh";
    plugins = zshModule.options.programs.zsh.plugins;
    initExtra = zshModule.options.programs.zsh.initExtra;
    aliases = zshModule.options.programs.zsh.shellAliases;

    starship = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };

      transientPrompt = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };

      theme = lib.mkOption {
        type = lib.types.str;
        default = "tokyo-night";
      };
    };
  };

  config = lib.mkMerge [
    {}

    (lib.mkIf config.shells.zsh.enable
      {
        programs = {
          zsh = {
            enable = true;
            dotDir = ".config/zsh";
            initExtra = ''
              bindkey '^[[1;5C' forward-word
              bindkey '^[[1;5D' backward-word
              bindkey '^[OA' history-substring-search-up
              bindkey '^[OB' history-substring-search-down
            '';
            plugins = [
              {
                name = "fzf-tab";
                src = pkgs.fetchFromGitHub {
                  owner = "Aloxaf";
                  repo = "fzf-tab";
                  rev = "v1.1.2";
                  sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
                };
              }

              {
                name = "zsh-autosuggestions";
                src = pkgs.fetchFromGitHub {
                  owner = "zsh-users";
                  repo = "zsh-autosuggestions";
                  rev = "v0.7.0";
                  sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
                };
              }

              {
                name = "zsh-syntax-highlighting";
                src = pkgs.fetchFromGitHub {
                  owner = "zsh-users";
                  repo = "zsh-syntax-highlighting";
                  rev = "0.8.0";
                  sha256 = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
                };
              }

              {
                name = "zsh-history-substring-search";
                src = pkgs.fetchFromGitHub {
                  owner = "zsh-users";
                  repo = "zsh-history-substring-search";
                  rev = "v1.1.0";
                  sha256 = "sha256-GSEvgvgWi1rrsgikTzDXokHTROoyPRlU0FVpAoEmXG4=";
                };
              }
            ];
            shellAliases = {
              gss = "git status -s";
              gaa = "git add --all";
              gcm = "git commit -m";
              gco = "git checkout";
              grb = "git rebase";
              gst = "git stash";
              gpuoc = "git push --set-upstream origin \$(git symbolic-ref --short HEAD)";
              gf = "git fetch --all --prune";
              gd = "git diff";
              la = "ls -la";
            };
          };

          fzf = {
            enable = true;
          };

          eza = {
            enable = true;
          };
        };
      })

    (lib.mkIf config.shells.zsh.starship.enable
      {
        programs = {
          zsh = {
            initExtra = lib.mkIf config.shells.zsh.starship.transientPrompt (builtins.readFile ./starship/transient.zsh);
          };

          starship = {
            enable = true;
            settings = import ./starship/themes/${config.shells.zsh.starship.theme}.nix {inherit lib;};
          };
        };
      })
  ];
}
