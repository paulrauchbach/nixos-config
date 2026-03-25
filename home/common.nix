{ pkgs, user, fullName, email, hostname, ... }:

{
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    thunderbird
    keepassxc
    discord
    git
    ripgrep
    eza
    zsh
    oh-my-zsh
    ghostty
    codex
    claude-code
  ];

  programs.git = {
    enable = true;
    settings.user.name = fullName;
    settings.user.email = email;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake path:$HOME/nixos-config#${hostname}";
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "eza"
        "docker"
        "python"
      ];
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      search.default = "ddg";
      search.force = true;
      settings = {
        "browser.startup.page" = 3;
        "browser.sessionstore.resume_from_crash" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        "browser.translations.neverTranslateLanguages" = "de,en";
        "browser.tabs.warnOnClose" = false;
        "signon.rememberSignons" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.available" = "off";
      };
    };

    policies = {
      DisableTelemetry = true;
    };
  };
}
