{ username, ... }:

{
  imports = [
    ../base.nix
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  # Some desktop packages in this config are unfree.
  nixpkgs.config.allowUnfree = true;

  services.printing.enable = true;

  # Useful commands while learning:
  #   sudo nixos-rebuild switch --flake path:.#desktop
  #   sudo nixos-rebuild boot --flake path:.#desktop
  #   nix flake show path:.
  #   nixos-option lanzaboote.enable
  #   nixos-option gnome.enable
  #   journalctl -b | grep -i -E 'nvidia|xrandr|modeset'
  #   journalctl -b -u display-manager

  # system packages
  desktop.theme = "tokyo-night";
  dev.enable = true;
  gnome.enable = true;
  lanzaboote.enable = true;
  nvidia.enable = true;
  logitechGProKeyboard.enable = true;
  steam.enable = true;

  # user packages
  home-manager.users.${username} = {
    dev.enable = true;
    git.enable = true;
    vscode.enable = true;
    firefox.enable = true;
  };
}
