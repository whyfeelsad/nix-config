{
  description = "Aaron's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    daeuniverse.url = "github:daeuniverse/flake.nix";
  };

  outputs = inputs @ {
    nixpkgs,
    disko,
    impermanence,
    nix-flatpak,
    home-manager,
    ...
  }: let
    myvars = import ./vars;
  in {
    nixosConfigurations = {
      mechrevo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit myvars;
        };
        modules = [
          ./hosts/mechrevo/configuration.nix
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          inputs.daeuniverse.nixosModules.daed
        ];
      };
    };
  };
}
