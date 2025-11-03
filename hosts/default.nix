{ inputs, ... }:
let
  mkSystem =
    host:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ../modules
        ./${host}
      ];
    };
in
{
  nixosConfigurations = {
    mechrevo = mkSystem "mechrevo";
  };
}
