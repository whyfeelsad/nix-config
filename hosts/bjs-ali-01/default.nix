{
  imports = [
    ./network.nix
    ./hardware.nix
  ];

  # 北京 阿里云 2C-2G-40G
  services'.vnstat.enable = true;
  services'.openssh.enable = true;
  security'.firewall.enable = true;

  services'.dae.enable = true;
  services'.tang.enable = true;
  services'.snell-server.enable = true;
}
