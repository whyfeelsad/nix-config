{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mtr
    nmap
    socat
    ipcalc
    iperf3
    tcpdump
    dnsutils
    traceroute
  ];
}
