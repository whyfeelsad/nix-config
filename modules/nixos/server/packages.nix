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

    # core tools
    fastfetch
    neovim
    just
    git
    git-lfs
    lazygit

    # archives
    zip
    xz
    zstd
    unzipNLS
    p7zip

    # Text Processing
    # Docs: https://github.com/learnbyexample/Command-line-text-processing
    gnugrep
    gnused
    gawk
    jq

    # networking tools
    mtr
    iperf3
    dnsutils
    ldns
    wget
    curl
    aria2
    socat
    nmap
    ipcalc

    # misc
    file
    findutils
    which
    tree
    gnutar
    rsync
  ];

  # BCC - Tools for BPF-based Linux IO analysis, networking, monitoring, and more
  # https://github.com/iovisor/bcc
  programs.bcc.enable = true;
}
