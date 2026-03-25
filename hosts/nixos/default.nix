{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/users/main-user.nix
    ../../modules/nixos/desktops/gnome.nix
    ../../modules/nixos/hardware/nvidia.nix
  ];

  networking.hostName = "nixos";
}
