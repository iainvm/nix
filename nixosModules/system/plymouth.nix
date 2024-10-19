{
  lib,
  config,
  system,
  nixpkgs,
  ...
}: let
  pkgs = nixpkgs.legacyPackages.${system};
in {
  options.plymouth = {
    enable = lib.mkEnableOption "enable plymouth";
  };

  config = lib.mkIf config.plymouth.enable {
    boot.initrd.systemd.enable = true;
    boot.plymouth = {
      enable = true;
      theme = "hexagon_2";
      themePackages = [
        pkgs.adi1090x-plymouth-themes
      ];
    };

    # # Enable "Silent Boot"
    # consoleLogLevel = 0;
    # initrd.verbose = false;
    # kernelParams = [
    #   "quiet"
    #   "splash"
    #   "boot.shell_on_fail"
    #   "loglevel=3"
    #   "rd.systemd.show_status=false"
    #   "rd.udev.log_level=3"
    #   "udev.log_priority=3"
    # ];
    # # Hide the OS choice for bootloaders.
    # # It's still possible to open the bootloader list by pressing any key
    # # It will just not appear on screen unless a key is pressed
    # loader.timeout = 0;
  };
}
