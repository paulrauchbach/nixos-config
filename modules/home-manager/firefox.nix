{ config, lib, ... }:

let
  cfg = config.firefox;
in
{
  options = {
    firefox.enable = lib.mkEnableOption "Firefox";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}
