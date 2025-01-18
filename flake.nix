{
  description = "Aaron's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs @ {
    nixpkgs,
    disko,
    impermanence,
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
          ./hosts/mechrevo
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
        ];
      };
    };
  };
}
