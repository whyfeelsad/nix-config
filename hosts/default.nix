inputs:
let
  myvars = import ../vars;

  hmModules = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs myvars; };
        users.aaron = import ../home;
      };
    }
  ];

  mkSystem =
    host:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs myvars; };
      modules = [
        ./${host}/configuration.nix
      ]
      ++ hmModules;
    };
in
{
  nixosConfigurations = {
    mechrevo = mkSystem "mechrevo";
  };
}
