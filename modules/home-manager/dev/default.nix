{ config, lib, pkgs, ... }:

let
  cfg = config.dev;
in
{
  options.dev.enable = lib.mkEnableOption "developer user tooling";

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = [
        pkgs."claude-code"
        pkgs.gh
      ];
    }
    (import ./node.nix { inherit config lib pkgs; })
    (import ./python.nix { inherit pkgs; })
  ]);
}
