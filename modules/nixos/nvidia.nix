{ config, lib, ... }:

let
  cfg = config.nvidia;
in
{
  options = {
    nvidia.enable = lib.mkEnableOption "NVIDIA graphics support";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.graphics.enable = true;

    # Restored from your previous working setup.
    hardware.nvidia.open = true;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.powerManagement.enable = true;
  };
}
