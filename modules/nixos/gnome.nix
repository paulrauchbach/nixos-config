{ config, lib, pkgs, ... }:

let
  cfg = config.gnome;
in
{
  options = {
    gnome.enable = lib.mkEnableOption "GNOME desktop with GDM";
  };

  config = lib.mkIf cfg.enable {
    # Useful desktop debugging commands:
    #   systemctl status display-manager
    #   journalctl -b -u display-manager

    programs.dconf.enable = true;

    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.displayManager.defaultSession = "gnome";
    services.desktopManager.gnome.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    fonts.packages = [
      pkgs.nerd-fonts.caskaydia-mono
    ];

    environment.systemPackages = [
      pkgs.gnome-tweaks
      pkgs.gnome-extension-manager
      pkgs.gnomeExtensions.appindicator
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.gnomeExtensions.just-perfection
      pkgs.gnomeExtensions.tactile
      pkgs.gnomeExtensions.user-themes
    ];
  };
}
