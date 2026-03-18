{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.hardware.sound = {
    enable = lib.mkEnableOption "sound";

    noisetorch.enable = lib.mkEnableOption "noisetorch";
    noisetorch.device-unit = lib.mkOption {
      type = lib.types.str;
      description = "systemd device unit of microphone";
    };
    noisetorch.device-id = lib.mkOption {
      type = lib.types.str;
      description = "microphone source from noisetorch";
    };
    noisetorch.threshold = lib.mkOption {
      type = lib.types.int;
      description = "noise suppression threshold";
      default = 80;
    };
  };

  config = lib.mkMerge [
    {}

    (
      lib.mkIf config.core.hardware.sound.enable
      {
        security.rtkit.enable = true;
        services.pipewire = {
          enable = true;
          audio.enable = true;
          pulse.enable = true;
          wireplumber.enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
        };

        environment.systemPackages = with pkgs; [
          playerctl # Used to control players with media keys
          crosspipe # Pipewire audio patchbay
          pavucontrol # Volume controls
        ];
      }
    )

    (
      lib.mkIf config.core.hardware.sound.noisetorch.enable
      {
        environment.systemPackages = with pkgs; [
          noisetorch # Noise Suppression
        ];

        security.wrappers.noisetorch = {
          owner = "root";
          group = "root";
          capabilities = "cap_sys_resource+ep";
          source = "${pkgs.noisetorch}/bin/noisetorch";
        };

        # Noisetorch service
        systemd.user.services.noisetorch = {
          enable = true;
          description = "NoiseTorch Noise Suppression";
          after = ["${config.core.hardware.sound.noisetorch.device-unit}"];
          requires = ["${config.core.hardware.sound.noisetorch.device-unit}"];

          serviceConfig = {
            Type = "simple";
            RemainAfterExit = "yes";
            ExecStart = "${pkgs.noisetorch}/bin/noisetorch -i -s ${config.core.hardware.sound.noisetorch.device-id} -t ${toString config.core.hardware.sound.noisetorch.threshold}";
            ExecStop = "${pkgs.noisetorch}/bin/noisetorch -u";
            Restart = "on-failure";
            RestartSec = 3;
          };

          wantedBy = ["default.target"];
        };
      }
    )
  ];
}
