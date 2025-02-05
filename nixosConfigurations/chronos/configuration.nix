{
  self,
  inputs,
  nixpkgs,
  ...
}: let
  system = "x86_64-linux";
  computerName = "chronos";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.nur.overlays.default
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
        environment.systemPackages = with pkgs; [
          home-manager
        ];

        # Flatpak
        services.flatpak.enable = true;

        # Nix
        system.stateVersion = "24.11";

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
            keyring.enable = true;
            # Window Manager
            hyprland.enable = true;
          };

          # Applications
          applications = {
            steam.enable = true; # Has to be installed system wide for openGL
            thunar.enable = true;
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
                home-manager = ../../homeConfigurations/iain/home.nix;
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
