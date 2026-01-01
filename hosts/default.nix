{
  self,
  inputs,
  lib,
  ...
}:
let
  mkNixosSystem = host: _: {
    ${host} = lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        {
          core' = {
            userName = "aaron";
            hostName = host;
          };
        }
        self.nixosModules.default
        ./${host}
      ];
    };
  };
in
lib.pipe (builtins.readDir ./.) [
  (lib.filterAttrs (n: _: n != "default.nix"))
  (lib.concatMapAttrs mkNixosSystem)
]
