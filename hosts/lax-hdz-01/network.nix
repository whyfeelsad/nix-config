{
  systemd.network.enable = true;
  services.resolved.enable = false;
  networking.useDHCP = false;

  systemd.network.networks.eth0 = {
    DHCP = "yes";
    matchConfig.Name = "eth0";
  };

  networking.nameservers = [
    "1.1.1.1"
    "2606:4700:4700::1111"
  ];
}
