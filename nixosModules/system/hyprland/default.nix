{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  options.core.system.hyprland = {
    enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.core.system.hyprland.enable {
    # Desktop Environment
    services.xserver = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      xdg-desktop-portal-hyprland
      nordzy-cursor-theme
    ];

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      HYPRCURSOR_THEME = "Nordzy-hyprcursors-catppuccin-frappe-green";
      HYPRCURSOR_SIZE = "24";
    };

    xdg.portal = {
      enable = true;
      extraPortals = [];
    };

    # Setting to make ultrawide the primary monitor for Xwayland
    # Broken
    # https://github.com/NixOS/nixpkgs/issues/72250
    # https://github.com/NixOS/nixpkgs/issues/30796
    # services.xserver.xrandrHeads = [
    #   {
    #     output = "DP-4";
    #     primary = true;
    #   }
    # ];
  };
}
