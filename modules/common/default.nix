{
  imports = [
    ./nix
    ./i18n
    ./sudo
    ./users
    ./loader
    ./openssh
    ./firewall
    ./packages
    ./monitoring
  ];

  documentation.nixos.enable = false;
}
