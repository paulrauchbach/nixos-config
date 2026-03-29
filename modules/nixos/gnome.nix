{ config, lib, pkgs, ... }:

let
  cfg = config.gnome;
  themePresets = import ../theme-presets.nix;
  theme = themePresets.${config.desktop.theme};
in
{
  options = {
    desktop.theme = lib.mkOption {
      type = lib.types.enum (builtins.attrNames themePresets);
      default = "tokyo-night";
      description = "Desktop theme preset shared with the GDM greeter.";
    };

    gnome.enable = lib.mkEnableOption "GNOME desktop with GDM";
  };

  config = lib.mkIf cfg.enable {
    # Useful desktop debugging commands:
    #   systemctl status display-manager
    #   journalctl -b -u display-manager

    programs.dconf.enable = true;
    programs.dconf.profiles.gdm = {
      enableUserDb = false;
      databases = [
        {
          settings = {
            "org/gnome/desktop/background" = {
              picture-uri = "file://${theme.wallpaper}";
              picture-uri-dark = "file://${theme.wallpaper}";
              picture-options = "zoom";
            };

            "org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
              cursor-theme = "Bibata-Modern-Ice";
              gtk-theme = theme.gtkTheme;
              icon-theme = theme.iconTheme;
            };

            "org/gnome/desktop/screensaver" = {
              picture-uri = "file://${theme.wallpaper}";
              picture-uri-dark = "file://${theme.wallpaper}";
              picture-options = "zoom";
            };
          };
        }
      ];
    };

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
      pkgs.gnomeExtensions.blur-my-shell
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.gnomeExtensions.just-perfection
      pkgs.gnomeExtensions.space-bar
      pkgs.gnomeExtensions.tactile
      pkgs.gnomeExtensions.undecorate
      pkgs.gnomeExtensions.user-themes
      pkgs.bibata-cursors
      pkgs.yaru-theme
    ];
  };
}
