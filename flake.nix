{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, lanzaboote, ... }:
    let
      lib = nixpkgs.lib;

      mkHost = {
        name,
        system ? "x86_64-linux",
        user ? "paul",
        fullName ? "Paul",
        email ? "rauchbach.paul@gmail.com",
        nixosModules ? [ ],
        homeModules ? [ ],
      }:
        lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit user fullName email;
            hostname = name;
          };

          modules =
            [
              (./hosts + "/${name}/default.nix")

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit user fullName email;
                  hostname = name;
                };
                home-manager.users.${user} = {
                  imports = [
                    ./home/common.nix
                    ./home/dev.nix
                  ] ++ homeModules;
                };
              }
            ]
            ++ nixosModules;
        };
    in
    {
      nixosConfigurations = {
        nixos = mkHost {
          name = "nixos";
          nixosModules = [
            lanzaboote.nixosModules.lanzaboote
            ./modules/nixos/security/lanzaboote.nix
          ];
          homeModules = [
            ./home/desktops/gnome.nix
            ./home/hosts/nixos/monitors.nix
            ./home/profiles/desktop.nix
          ];
        };

        # Enable this after generating `hosts/laptop/hardware-configuration.nix`.
        # laptop = mkHost {
        #   name = "laptop";
        #   homeModules = [ ./home/profiles/laptop.nix ];
        # };
      };
    };
}
