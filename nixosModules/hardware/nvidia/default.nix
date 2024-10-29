{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.hardware.nvidia = {
    enable = lib.mkEnableOption "enable nvidia";
  };

  config = lib.mkIf config.core.hardware.nvidia.enable {
    boot.kernelParams = ["nvidia_drm.fbdev=1"];
    services.xserver.videoDrivers = ["nvidia"];

    hardware = {
      graphics.enable = true;
      nvidia = {
        open = true;
        nvidiaSettings = true;
        modesetting.enable = true;

        powerManagement = {
          enable = false;
          finegrained = false;
        };

        package = pkgs.unstable.linuxPackages.nvidiaPackages.latest;
      };
    };
  };
}
