{ pkgs, ... }:
{
  hm' = {
    home.packages = with pkgs; [
      # archives
      zip
      xz
      zstd
      unzipNLS
      p7zip

      # basic
      fd
      fzf
      just
      lazygit
      alejandra

      # monitoring
      duf # disk usage analyzer
      gdu # Disk usage analyzer with console interface
      ncdu # disk utilization
      gping # Ping, but with a graph
      bottom # process
      du-dust # Like du but more intuitive

      # utilities
      jq
      gawk
      gnused
      gnugrep
    ];
  };

  environment.systemPackages = with pkgs; [
    # basic
    git
    git-lfs
    lsof
    which
    psmisc
    rsync
    openssl

    # monitoring
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

    # network
    mtr
    curl
    wget
    nmap
    socat
    ipcalc
    iperf3
    tcpdump
    dnsutils
    traceroute
  ];
}
