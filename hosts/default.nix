{
  self,
  inputs,
  lib,
}: let
  inherit (inputs) nix-darwin;
  mkDarwinSystem = host: _: {
    ${host} = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit self inputs;};
      modules = [
        {
          core' = {
            userName = "aaron";
            hostName = host;
          };
        }
        self.darwinModules.default
        ./${host}
      ];
    };
  };
in
  lib.pipe (builtins.readDir ./.) [
    (lib.filterAttrs (n: _: n != "default.nix"))
    (lib.concatMapAttrs mkDarwinSystem)
  ]
