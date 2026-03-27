{ pkgs, user, fullName, email, hostname, ... }:

{
  imports = [
    ./programs/firefox.nix
  ];

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


}
