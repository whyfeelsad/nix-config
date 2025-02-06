{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    ethtool
    hdparm
    dmidecode
    parted

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
    socat
    nmap
    ipcalc

    # core tools
    fastfetch
    neovim
    git
    git-lfs

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
