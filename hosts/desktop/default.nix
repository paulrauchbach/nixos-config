{ fullName, hostname, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  # Useful commands while learning:
  #   sudo nixos-rebuild switch --flake path:.#desktop
  #   sudo nixos-rebuild boot --flake path:.#desktop
  #   nix flake show path:.
  #   nixos-option lanzaboote.enable
  #   nixos-option gnome.enable
  #   journalctl -b | grep -i -E 'nvidia|xrandr|modeset'
  #   journalctl -b -u display-manager

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # VS Code is unfree, so we allow unfree packages explicitly.
  nixpkgs.config.allowUnfree = true;

  users.users.${username} = {
    isNormalUser = true;
    description = fullName;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  gnome.enable = true;
  lanzaboote.enable = true;
  nvidia.enable = true;

  home-manager.users.${username} = {
    git.enable = true;
    omakub.enable = true;
    omakub.theme = "tokyo-night";
    vscode.enable = true;
    firefox.enable = true;
  };

  system.stateVersion = "25.11";
}
