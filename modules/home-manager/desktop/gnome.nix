{ pkgs, ... }:

let
  blurMyShellUuid = pkgs.gnomeExtensions.blur-my-shell.extensionUuid;
  tactileUuid = pkgs.gnomeExtensions.tactile.extensionUuid;
  dashToDockUuid = pkgs.gnomeExtensions.dash-to-dock.extensionUuid;
  justPerfectionUuid = pkgs.gnomeExtensions.just-perfection.extensionUuid;
  spaceBarUuid = pkgs.gnomeExtensions.space-bar.extensionUuid;
  undecorateUuid = pkgs.gnomeExtensions.undecorate.extensionUuid;
  userThemesUuid = pkgs.gnomeExtensions.user-themes.extensionUuid;
  appIndicatorUuid = pkgs.gnomeExtensions.appindicator.extensionUuid;
in
{
  home.packages = [
    pkgs.ulauncher
  ];

  xdg.configFile."ulauncher/settings.json" = {
    force = true;
    text = builtins.toJSON {
      blacklisted-desktop-dirs = "/usr/share/locale:/usr/share/app-install:/usr/share/kservices5:/usr/share/fk5:/usr/share/kservicetypes5:/usr/share/applications/screensavers:/usr/share/kde4:/usr/share/mimelnk";
      clear-previous-query = true;
      disable-desktop-filters = false;
      grab-mouse-pointer = false;
      hotkey-show-app = "<Primary>space";
      render-on-screen = "mouse-pointer-monitor";
      show-indicator-icon = true;
      show-recent-apps = "0";
      terminal-command = "";
      theme-name = "dark";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      monospace-font-name = "CaskaydiaMono Nerd Font 11";
      enable-animations = true;
      enable-hot-corners = false;
      clock-format = "24h";
      show-battery-percentage = true;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      edge-tiling = true;
      center-new-windows = true;
      workspaces-only-on-primary = false;
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 6;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>w" ];
      maximize = [ "<Super>Up" ];
      begin-resize = [ "<Super>BackSpace" ];
      toggle-fullscreen = [ "<Shift>F11" ];
      switch-input-source = [ ];
      switch-input-source-backward = [ ];
      switch-to-workspace-left = [ "<Super>Page_Up" ];
      switch-to-workspace-right = [ "<Super>Page_Down" ];
      move-to-workspace-left = [ "<Shift><Super>Page_Up" ];
      move-to-workspace-right = [ "<Shift><Super>Page_Down" ];

      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];

      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      move-to-workspace-5 = [ "<Shift><Super>5" ];
      move-to-workspace-6 = [ "<Shift><Super>6" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ulauncher/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ulauncher" = {
      name = "Ulauncher";
      command = "ulauncher-toggle";
      binding = "<Super>space";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        appIndicatorUuid
        blurMyShellUuid
        dashToDockUuid
        justPerfectionUuid
        spaceBarUuid
        tactileUuid
        undecorateUuid
        userThemesUuid
      ];

      favorite-apps = [
        "firefox.desktop"
        "Alacritty.desktop"
        "code.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ "<Alt>1" ];
      switch-to-application-2 = [ "<Alt>2" ];
      switch-to-application-3 = [ "<Alt>3" ];
      switch-to-application-4 = [ "<Alt>4" ];
      switch-to-application-5 = [ "<Alt>5" ];
      switch-to-application-6 = [ "<Alt>6" ];
      switch-to-application-7 = [ "<Alt>7" ];
      switch-to-application-8 = [ "<Alt>8" ];
      switch-to-application-9 = [ "<Alt>9" ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dock-fixed = false;
      autohide = true;
      intellihide = true;
      dash-max-icon-size = 40;
      hot-keys = false;
      show-trash = false;
      show-mounts = false;
      show-apps-at-top = true;
      click-action = "focus-minimize-or-previews";
    };

    "org/gnome/shell/extensions/just-perfection" = {
      activities-button = false;
      animation = 2;
      dash-app-running = true;
      startup-status = 0;
      workspace = true;
      workspace-popup = false;
    };

    "org/gnome/shell/extensions/tactile" = {
      show-tiles = [ "<Super>t" ];
      grid-cols = 3;
      grid-rows = 2;
      gap-size = 24;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      sigma = 30;
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur = true;
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/space-bar/behavior" = {
      indicator-style = "workspaces-bar";
      position = "left";
      position-index = 1;
      system-workspace-indicator = false;
      always-show-numbers = true;
      show-empty-workspaces = true;
      enable-custom-label = true;
      enable-custom-label-in-menu = true;
      custom-label-named = "{{number}}";
      custom-label-unnamed = "{{number}}";
      smart-workspace-names = false;
      scroll-wheel = "workspaces-bar";
    };

    "org/gnome/shell/extensions/space-bar/shortcuts" = {
      enable-activate-workspace-shortcuts = false;
      enable-move-to-workspace-shortcuts = true;
      open-menu = [ ];
    };

    "org/gnome/shell/extensions/space-bar/appearance" = {
      workspaces-bar-padding = 6;
      workspace-margin = 4;
      active-workspace-border-color = "rgba(255,255,255,0.08)";
      active-workspace-border-radius = 4;
      active-workspace-border-width = 1;
      active-workspace-padding-h = 14;
      active-workspace-padding-v = 4;

      inactive-workspace-border-color = "rgba(255,255,255,0.06)";
      inactive-workspace-border-radius = 4;
      inactive-workspace-border-width = 1;
      inactive-workspace-padding-h = 14;
      inactive-workspace-padding-v = 4;

      empty-workspace-border-color = "rgba(255,255,255,0.06)";
      empty-workspace-border-radius = 4;
      empty-workspace-border-width = 1;
    };
  };

  systemd.user.services.ulauncher = {
    Unit = {
      Description = "Ulauncher application launcher";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.ulauncher}/bin/ulauncher --hide-window";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
