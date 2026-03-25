{ ... }:

{
  programs.dconf.enable = true;

  services.xserver.enable = true;

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  services.libinput.mouse.accelProfile = "flat";
  services.libinput.touchpad.accelProfile = "flat";

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
}
