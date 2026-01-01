{
  systemd.network.enable = true;
  services.resolved.enable = false;
  networking.useDHCP = false;

  systemd.network.networks.eth0 = {
    DHCP = "yes";
    matchConfig.Name = "eth0";
  };

  networking.nameservers = [
    "223.5.5.5"
    "223.6.6.6"
  ];
}
