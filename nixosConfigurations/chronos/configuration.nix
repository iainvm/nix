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
        nix-flakes.enable = true;

        # System
        plymouth = {
          enable = true;
          silent-boot = true;
        };
        en-gb.enable = true;
        nvidia.enable = true;
        bluetooth.enable = true;
        network = {
          enable = true;
          hostName = computerName;
        };
        system = {
          sound.enable = true;
        };

        # Environment
        sddm.enable = true;
        hyprland.enable = true;
        applications = {
          "1password".enable = true;
          thunar.enable = true;
        };

        # System Packages
        zsh.enable = true;

        # Users
        simple-users = {
          users = {
            iain = {
              group = "iain";
              shell = pkgs.zsh;
              extraGroups = ["wheel"];
              home-manager = ./users/iain/configuration.nix;
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
