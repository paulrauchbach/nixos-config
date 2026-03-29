{ config, lib, pkgs, ... }:

let
  cfg = config.steam;
in
{
  options.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      package = pkgs.steam;
    };
  };
}
