{ config, lib, pkgs, username, ... }:

let
  cfg = config.dev;
in
{
  options.dev.enable = lib.mkEnableOption "developer tooling";

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;

    users.users.${username}.extraGroups = [ "docker" ];

    environment.systemPackages = [
      pkgs.docker-compose
    ];
  };
}
