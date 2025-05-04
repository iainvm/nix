{
  lib,
  pkgs,
  config,
  ...
}: let
  cfgFile = pkgs.writeText "weston.ini" (builtins.concatStringsSep "\n\n" (
    [
      ''
        [keyboard]
        keymap_options=terminate:ctrl_alt_bksp
        keymap_variant=

        [libinput]
        enable-tap=true
        left-handed=false
      ''
    ]
    ++ (map (id: ''
        [output]
        name=${id}
        mode=off
      '')
      config.core.display-manager.sddm.disabled-displays)
  ));
in {
  options.core.display-manager.sddm = {
    enable = lib.mkEnableOption "enable sddm";
    disabled-displays = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of display IDs to disable.";
    };
  };

  config = lib.mkIf config.core.display-manager.sddm.enable {
    security.pam.services.sddm.enableGnomeKeyring = true;
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      wayland.enable = true;
      autoNumlock = true;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
      ];

      settings = {
        Wayland = {
          CompositorCommand = "${pkgs.weston}/bin/weston --shell=kiosk -c ${cfgFile}";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      (sddm-astronaut.override {
        embeddedTheme = "astronaut";
      })
    ];

    core.system.keyring.enable = true;
  };
}
