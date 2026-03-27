{ config, lib, pkgs, ... }:

let
  cfg = config.omakub;

  tactileUuid = pkgs.gnomeExtensions.tactile.extensionUuid;
  dashToDockUuid = pkgs.gnomeExtensions.dash-to-dock.extensionUuid;
  justPerfectionUuid = pkgs.gnomeExtensions.just-perfection.extensionUuid;
  userThemesUuid = pkgs.gnomeExtensions.user-themes.extensionUuid;
  appIndicatorUuid = pkgs.gnomeExtensions.appindicator.extensionUuid;
in
{
  options = {
    omakub.enable = lib.mkEnableOption "Omakub-like GNOME desktop styling";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.ulauncher
    ];

    home.sessionVariables = {
      TERMINAL = "alacritty";
    };

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
        package = pkgs.tokyonight-gtk-theme;
        name = "Tokyonight-Dark";
      };

      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          decorations = "None";
          opacity = 0.95;
          padding = {
            x = 12;
            y = 12;
          };
        };

        font = {
          normal = {
            family = "CaskaydiaMono Nerd Font";
            style = "Regular";
          };

          size = 12.0;
        };
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "Tokyonight-Dark";
        icon-theme = "Papirus-Dark";
        cursor-theme = "Bibata-Modern-Ice";
        monospace-font-name = "CaskaydiaMono Nerd Font 11";
        enable-animations = false;
        clock-format = "24h";
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = false;
        edge-tiling = true;
      };

      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 6;
      };

      "org/gnome/desktop/wm/keybindings" = {
        switch-input-source = [ ];
        switch-input-source-backward = [ ];

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
          dashToDockUuid
          justPerfectionUuid
          tactileUuid
          userThemesUuid
        ];

        favorite-apps = [
          "firefox.desktop"
          "Alacritty.desktop"
          "code.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        dock-position = "BOTTOM";
        dock-fixed = false;
        autohide = true;
        intellihide = true;
        dash-max-icon-size = 40;
        hot-keys = true;
        show-trash = false;
        show-mounts = false;
        show-apps-at-top = true;
        click-action = "focus-minimize-or-previews";
      };

      "org/gnome/shell/extensions/just-perfection" = {
        activities-button = false;
        animation = 0;
        startup-status = 0;
        workspace-popup = false;
      };

      "org/gnome/shell/extensions/tactile" = {
        show-tiles = [ "<Super>t" ];
        grid-cols = 3;
        grid-rows = 2;
        gap-size = 8;
        text-color = "#c0caf5";
        border-color = "#7aa2f7";
        background-color = "#1a1b26";
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "Tokyonight-Dark";
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
  };
}
