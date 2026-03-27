{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/programs/steam.nix
    ../../modules/nixos/users/main-user.nix
    ../../modules/nixos/desktops/gnome.nix
    ../../modules/nixos/hardware/nvidia.nix
    ../../modules/nixos/hardware/logitech-gpro-keyboard.nix
  ];

  hardware.logitechGProKeyboard = {
    enable = true;
    color = "188746";
  };

  networking.hostName = "nixos";
}
