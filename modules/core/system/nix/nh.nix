{ config, ... }:
let
  inherit (config.globals) configDirectory;
in
{
  hm'.programs.nh = {
    enable = true;
    flake = "${configDirectory}";
    clean = {
      enable = true;
      extraArgs = "--keep 5";
    };
  };
}
