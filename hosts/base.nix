{ fullName, hostname, username, ... }:

{
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  console.keyMap = "de";

  environment.pathsToLink = [ "/share/zsh" ];

  users.users.${username} = {
    isNormalUser = true;
    description = fullName;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "25.11";
}
