{ lib, ... }:
let
  listModules =
    dir:
    lib.pipe (builtins.readDir dir) [
      (lib.mapAttrsToList (
        name: type:
        let
          path = dir + "/${name}";
          isNixDir = type == "directory" && builtins.pathExists (path + "/default.nix");
        in
        if isNixDir then
          [ (path + "/default.nix") ]
        else if type == "directory" then
          listModules path
        else
          [ ]
      ))
      lib.flatten
    ];
in
{
  imports = (listModules ./core) ++ (listModules ./server) ++ (listModules ./desktop);
}