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

    aliases = {
      gss = "git status -s";
      gaa = "git add --all";
      gcm = "git commit -m";
      gco = "git checkout";
      grb = "git rebase";
      gst = "git stash";
      gpuoc = "git push --set-upstream origin \$(git symbolic-ref --short HEAD)";

      la = "ls -la";
    };

    initExtra = ''
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
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.1.0";
          sha256 = "sha256-GSEvgvgWi1rrsgikTzDXokHTROoyPRlU0FVpAoEmXG4=";
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
    ];
  };
}
