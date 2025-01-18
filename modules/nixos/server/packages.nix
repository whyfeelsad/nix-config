{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # system call monitoring
    strace
    ltrace
    tcpdump
    lsof

    # ebpf related tools
    # https://github.com/bpftrace/bpftrace
    bpftrace
    bpftop
    bpfmon

    # system monitoring
    sysstat
    iotop
    iftop
    btop
    htop
    nmon
    sysbench

    # system tools
    psmisc
    lm_sensors
    ethtool
    pciutils
    usbutils
    hdparm
    dmidecode
    parted
  ];

  # BCC - Tools for BPF-based Linux IO analysis, networking, monitoring, and more
  # https://github.com/iovisor/bcc
  programs.bcc.enable = true;
}
