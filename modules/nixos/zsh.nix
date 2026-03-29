{ config, lib, pkgs, username, ... }:

let
  cfg = config.zsh;
in
{
  options.zsh.enable = lib.mkEnableOption "Zsh login shell";

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;
    users.users.${username}.shell = pkgs.zsh;
  };
}
