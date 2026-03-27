{ config, lib, pkgs, ... }:

let
  theme = {
    tokyo-night = {
      gtkTheme = "Yaru-purple-dark";
      iconTheme = "Yaru-purple";
      shellTheme = "Yaru-purple-dark";
      wallpaper = ../assets/backgrounds/tokyo-night.svg;
      panelActiveWorkspaceBg = "rgba(122,162,247,0.28)";
      panelInactiveWorkspaceBg = "rgba(255,255,255,0.14)";
      panelTextColor = "rgba(255,255,255,0.92)";
      panelEmptyTextColor = "rgba(255,255,255,0.68)";
      tactileTextColor = "#c0caf5";
      tactileBorderColor = "#7aa2f7";
      tactileBackgroundColor = "#1a1b26";
    };

    nord = {
      gtkTheme = "Yaru-blue-dark";
      iconTheme = "Yaru-blue";
      shellTheme = "Yaru-blue-dark";
      wallpaper = ../assets/backgrounds/nord.svg;
      panelActiveWorkspaceBg = "rgba(136,192,208,0.30)";
      panelInactiveWorkspaceBg = "rgba(255,255,255,0.14)";
      panelTextColor = "rgba(255,255,255,0.92)";
      panelEmptyTextColor = "rgba(255,255,255,0.68)";
      tactileTextColor = "#e5e9f0";
      tactileBorderColor = "#88c0d0";
      tactileBackgroundColor = "#2e3440";
    };

    rose-pine = {
      gtkTheme = "Yaru-red-dark";
      iconTheme = "Yaru-red";
      shellTheme = "Yaru-red-dark";
      wallpaper = ../assets/backgrounds/rose-pine.svg;
      panelActiveWorkspaceBg = "rgba(235,111,146,0.30)";
      panelInactiveWorkspaceBg = "rgba(255,255,255,0.14)";
      panelTextColor = "rgba(255,255,255,0.92)";
      panelEmptyTextColor = "rgba(255,255,255,0.68)";
      tactileTextColor = "#f2e9e1";
      tactileBorderColor = "#ebbcba";
      tactileBackgroundColor = "#191724";
    };
  }.${config.desktop.theme};
in
{
  options.desktop.theme = lib.mkOption {
    type = lib.types.enum [
      "tokyo-night"
      "nord"
      "rose-pine"
    ];
    default = "tokyo-night";
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
