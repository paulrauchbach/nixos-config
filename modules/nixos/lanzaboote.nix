{ config, lib, pkgs, ... }:

let
  cfg = config.lanzaboote;
in
{
  options = {
    lanzaboote.enable = lib.mkEnableOption "Lanzaboote Secure Boot support";
  };

  config = lib.mkIf cfg.enable {
    # First-time Secure Boot setup:
    #   sudo sbctl create-keys
    #   sudo sbctl enroll-keys --microsoft
    #   sudo sbctl verify
    #   sudo nixos-rebuild switch --flake path:.#desktop

    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    environment.systemPackages = [ pkgs.sbctl ];
  };
}
