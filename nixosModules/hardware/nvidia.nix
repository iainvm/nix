{
  lib,
  pkgs,
  config,
  ...
}: {
  options.nvidia = {
    enable = lib.mkEnableOption "enable nvidia";
  };

  config = lib.mkIf config.nvidia.enable {
    boot.kernelParams = ["nvidia_drm.fbdev=1"];
    services.xserver.videoDrivers = ["nvidia"];

    environment.sessionVariables = rec {
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    hardware = {
      opengl.enable = true;
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
