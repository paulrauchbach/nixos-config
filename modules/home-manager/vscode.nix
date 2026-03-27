{ config, lib, pkgs, ... }:

let
  cfg = config.vscode;
in
{
  options = {
    vscode.enable = lib.mkEnableOption "Visual Studio Code";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
    };
  };
}
