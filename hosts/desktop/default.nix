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

  lanzaboote.enable = true;

  home-manager.users.${username} = {
    git.enable = true;
    vscode.enable = true;
    firefox.enable = true;
  };

  system.stateVersion = "25.11";
}
