{
  description = "Beginner-friendly NixOS config";

  # Inputs are the external projects this flake depends on.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Outputs are what this flake provides.
  outputs = { nixpkgs, home-manager, lanzaboote, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      # Personal details used by both NixOS and Home Manager.
      username = "paul";
      fullName = "Paul";
      email = "rauchbach.paul@gmail.com";

      # Home Manager settings shared by every host.
      homeManagerModule = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit username fullName email;
        };

        home-manager.users.${username} = {
          imports = [ ./modules/home-manager ];

          home.username = username;
          home.homeDirectory = "/home/${username}";
          home.stateVersion = "25.11";

          programs.home-manager.enable = true;
        };
      };

      # Helper for creating a host from ./hosts/<name>.
      mkHost = hostname:
        lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit username fullName email hostname;
          };

          modules = [
            (./hosts + "/${hostname}")
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
            homeManagerModule
          ];
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost "desktop";
      };
    };
}
