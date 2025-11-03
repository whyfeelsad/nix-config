# Reference: https://nixos.wiki/wiki/Sudo
let
  swBin = "/run/current-system/sw/bin";
in
{
  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "${swBin}/nix";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${swBin}/nixos-rebuild";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${swBin}/nix-collect-garbage";
            options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }
    ];
  };
}
