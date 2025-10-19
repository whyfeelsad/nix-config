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
    ./preservation
  ];

  documentation.nixos.enable = false;
}
