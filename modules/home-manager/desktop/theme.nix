{ config, lib, osConfig ? { }, pkgs, ... }:

let
  themePresets = import ../../theme-presets.nix;
  defaultTheme = lib.attrByPath [ "desktop" "theme" ] "tokyo-night" osConfig;
  theme = themePresets.${config.desktop.theme};
in
{
  options.desktop.theme = lib.mkOption {
    type = lib.types.enum (builtins.attrNames themePresets);
    default = defaultTheme;
    description = "Desktop theme preset.";
  };

  config = {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    gtk = {
      enable = true;

      theme = {
        package = pkgs.yaru-theme;
        name = theme.gtkTheme;
      };

      iconTheme = {
        package = pkgs.yaru-theme;
        name = theme.iconTheme;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = theme.gtkTheme;
        icon-theme = theme.iconTheme;
        cursor-theme = "Bibata-Modern-Ice";
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file://${theme.wallpaper}";
        picture-uri-dark = "file://${theme.wallpaper}";
        picture-options = "zoom";
      };

      "org/gnome/desktop/screensaver" = {
        picture-uri = "file://${theme.wallpaper}";
        picture-uri-dark = "file://${theme.wallpaper}";
        picture-options = "zoom";
      };

      "org/gnome/shell/extensions/tactile" = {
        text-color = theme.tactileTextColor;
        border-color = theme.tactileBorderColor;
        background-color = theme.tactileBackgroundColor;
      };

      "org/gnome/shell/extensions/space-bar/appearance" = {
        active-workspace-background-color = theme.panelActiveWorkspaceBg;
        active-workspace-text-color = theme.panelTextColor;
        inactive-workspace-background-color = theme.panelInactiveWorkspaceBg;
        inactive-workspace-text-color = theme.panelTextColor;
        empty-workspace-background-color = theme.panelInactiveWorkspaceBg;
        empty-workspace-text-color = theme.panelEmptyTextColor;
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = theme.shellTheme;
      };
    };
  };
}
