{
  self,
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  ...
}: let
  system = "x86_64-linux";
  computerName = "chronos";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      })
    ];
  };
in
  nixpkgs.lib.nixosSystem {
    inherit pkgs;
    system = system;
    specialArgs = {inherit inputs;};

    modules = [
      ./hardware-configuration.nix
      self.nixosModules.default
      {
        # Flatpak
        services.flatpak.enable = true;

        # Nix
        system.stateVersion = "24.05";

        core = {
          nix.flakes.enable = true;

          # Hardware
          hardware = {
            network = {
              enable = true;
              hostName = computerName;
            };
            sound.enable = true;
            nvidia.enable = true;
            bluetooth.enable = true;
          };

          # System
          system = {
            language.en-gb.enable = true;
            plymouth = {
              enable = true;
              silent-boot = true;
            };

            # Session Manager
            sddm.enable = true;
            # Window Manager
            hyprland.enable = true;
          };

          # Applications
          applications = {
            steam.enable = true; # Has to be installed system wide for openGL
            thunar.enable = true;
            _1password.enable = true;
          };

          # System Packages
          zsh.enable = true;

          # Users
          users = {
            users = {
              iain = {
                group = "iain";
                shell = pkgs.zsh;
                extraGroups = ["wheel"];
                home-manager = ./users/iain/configuration.nix;
              };
            };
          };
        };

        # Need to add to modules
        services.displayManager.sddm.settings = {
          Autologin = {
            Session = "hyprland.desktop";
            # Session = "gnome-xorg.desktop";
            User = "iain";
          };
        };
      }
    ];
  }
