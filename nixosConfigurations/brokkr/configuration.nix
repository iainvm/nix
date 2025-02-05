{
  self,
  inputs,
  nixpkgs,
  ...
}: let
  system = "x86_64-linux";
  computerName = "brokkr";
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
      inputs.nixos-hardware.nixosModules.dell-xps-15-9500
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
            thunderbolt.enable = true;
          };

          # System
          system = {
            language.en-gb.enable = true;
            plymouth = {
              enable = true;
              silent-boot = true;
            };

            # Session Manager
            ly.enable = true;
            # Window Manager
            hyprland.enable = true;
          };

          # Applications
          applications = {
            _1password = {
              enable = true;
              users = ["iain" "river"];
            };
            global-protect.enable = true;
            thunar.enable = true;
          };

          # System Packages
          zsh.enable = true;

          # Users
          users = {
            users = {
              iain = {
                host = "brokkr";
                group = "iain";
                shell = pkgs.zsh;
                extraGroups = ["networkmanager" "wheel"];
              };
            };
            users = {
              river = {
                host = "brokkr";
                group = "river";
                shell = pkgs.zsh;
                extraGroups = ["networkmanager"];
              };
            };
          };
        };
      }
    ];
  }
