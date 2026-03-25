{ pkgs, user, fullName, ... }:

{
  users.users.${user} = {
    isNormalUser = true;
    description = fullName;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };
}
