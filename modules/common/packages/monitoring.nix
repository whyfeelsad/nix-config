{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nmon
    btop
    htop
    iotop
    iftop
    strace
    sysstat
    tailspin
    bpftrace
    cpufetch
    fastfetch
  ];
}
