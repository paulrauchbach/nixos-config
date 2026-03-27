{ config, lib, pkgs, ... }:

let
  cfg = config.hardware.logitechGProKeyboard;

  gproLed = pkgs.g810-led;
in
{
  options.hardware.logitechGProKeyboard = {
    enable = lib.mkEnableOption "Logitech G PRO keyboard lighting";

    color = lib.mkOption {
      type = lib.types.strMatching "[0-9A-Fa-f]{6}";
      default = "ffffff";
      example = "00aaff";
      description = "Keyboard backlight color as a 6-digit RGB hex value.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ gproLed ];

    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c339", RUN+="${gproLed}/bin/gpro-led -a ${cfg.color}"
    '';

    systemd.services.logitech-gpro-keyboard-color = {
      description = "Apply Logitech G PRO keyboard color";
      wantedBy = [ "multi-user.target" ];
      wants = [ "systemd-udev-settle.service" ];
      after = [ "systemd-udev-settle.service" ];
      serviceConfig.Type = "oneshot";
      script = ''
        ${gproLed}/bin/gpro-led -a ${cfg.color}
      '';
    };
  };
}
