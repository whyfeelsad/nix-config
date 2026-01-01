{
  imports = [
    ./network.nix
    ./hardware.nix
  ];

  # LAX HostDZire 4C-6G-100G
  services'.vnstat.enable = true;
  services'.openssh.enable = true;
  security'.firewall.enable = true;

  services'.caddy.enable = true;
  services'.incus.enable = true;
  services'.podman.enable = true;
  services'.snell-server.enable = true;

  containers'.warp.enable = true;
  containers'.cloudflyer.enable = true;
  containers'.cloudflyer.domain = "cf.ou.al";
}
