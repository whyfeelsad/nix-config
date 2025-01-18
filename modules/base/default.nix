{lib, ...}: {
  imports = [
    ./i18n.nix
    ./nix.nix
    ./pkgs.nix
    ./ssh.nix
    ./sudo.nix
    ./sysctl.nix
    ./user-group.nix
  ];
}
