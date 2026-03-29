{ pkgs, ... }:

{
  home.packages = [
    pkgs.thunderbird
    pkgs.keepassxc
    pkgs.discord
  ];

  programs.eza.enable = true;
  programs.ripgrep.enable = true;
}
