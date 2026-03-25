{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/users/main-user.nix
    # ../../modules/nixos/desktops/gnome.nix
    # ../../modules/nixos/laptop/power.nix
  ];

  networking.hostName = "laptop";
}
