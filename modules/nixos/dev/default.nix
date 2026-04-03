{ config, lib, pkgs, username, ... }:

let
  cfg = config.dev;
in
{
  options.dev.enable = lib.mkEnableOption "developer tooling";

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Add any missing dynamic libraries for unpackaged
        # programs here, NOT in environment.systemPackages
      ];
    };

    users.users.${username}.extraGroups = [ "docker" ];

    environment.systemPackages = [
      pkgs.docker-compose
    ];
  };
}
