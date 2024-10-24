{
  lib,
  pkgs,
  config,
  system,
  ...
}: {
  options.plymouth = {
    enable = lib.mkEnableOption "enable plymouth";
    silent-boot = lib.mkEnableOption "enable silent boot";
  };

  config = lib.mkMerge [
    {}

    (
      lib.mkIf config.plymouth.enable
      {
        boot = {
          initrd.verbose = false;
          initrd.systemd.enable = true;
          plymouth = {
            enable = true;
            theme = "hexagon_2";
            themePackages = [
              pkgs.adi1090x-plymouth-themes
            ];
          };
        };
      }
    )

    (lib.mkIf config.plymouth.silent-boot
      {
        boot = {
          consoleLogLevel = 0;
          initrd.verbose = false;
          kernelParams = [
            "quiet"
            "splash"
            "boot.shell_on_fail"
            "loglevel=3"
            "rd.systemd.show_status=false"
            "rd.udev.log_level=3"
            "udev.log_priority=3"
          ];
          # Hide the OS choice for bootloaders.
          # It's still possible to open the bootloader list by pressing any key
          # It will just not appear on screen unless a key is pressed
          loader.timeout = 0;
        };
      })
  ];
}
