{ config, ... }:

let
  repo = "github:paulrauchbach/nixos-config";
in
{
  system.autoUpgrade = {
    enable = true;
    flake = "${repo}#${config.networking.hostName}";
    upgrade = false;
    dates = "daily";
    randomizedDelaySec = "45min";
    fixedRandomDelay = true;
    persistent = true;
    flags = [ "-L" ];
  };

  nix.gc = {
    automatic = true;
    dates = [ "weekly" ];
    randomizedDelaySec = "45min";
    persistent = true;
    options = "--delete-older-than 30d";
  };
}
