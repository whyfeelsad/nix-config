{
  lib,
  config,
  ...
}: {
  boot.kernel.sysctl = {
    # Bufferbloat mitigations + slight improvement in throughput & latency
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake"; # option fq & fq_codel

    # https://wiki.archlinux.org/title/sysctl
    "net.ipv4.tcp_max_tw_buckets" = 2000000;
    "net.ipv4.tcp_max_syn_backlog" = 8192;
    "net.ipv4.tcp_tw_reuse" = 1;

    ## TCP optimization
    # TCP Fast Open is a TCP extension that reduces network latency by packing
    # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
    # both incoming and outgoing connections:
    "net.ipv4.tcp_fastopen" = 3;
    "net.core.netdev_max_backlog" = 16384;
    "net.core.somaxconn" = 8192;
    "net.core.rmem_default" = 33554432;
    "net.core.rmem_max" = 33554432;
    "net.core.wmem_default" = 33554432;
    "net.core.wmem_max" = 33554432;
    "net.core.optmem_max" = 65536;
    "net.ipv4.tcp_rmem" = "4096 1048576 33554432";
    "net.ipv4.tcp_wmem" = "4096 1048576 33554432";
    "net.ipv4.udp_rmem_min" = 8192;
    "net.ipv4.udp_wmem_min" = 8192;

    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_keepalive_time" = 60;
    "net.ipv4.tcp_keepalive_intvl" = 10;
    "net.ipv4.tcp_keepalive_probes" = 6;
    "net.ipv4.tcp_mtu_probing" = 1;

    # Prevent bogus ICMP errors from filling up logs.
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

    # Reverse path filtering causes the kernel to do source validation of
    # packets received from all interfaces. This can mitigate IP spoofing.
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;

    # Do not accept IP source route packets (we're not a router)
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;

    # Don't send ICMP redirects (again, we're not a router)
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;

    # Refuse ICMP redirects (MITM mitigations)
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;

    # Protects against SYN flood attacks
    "net.ipv4.tcp_syncookies" = 1;

    # Incomplete protection again TIME-WAIT assassination
    "net.ipv4.tcp_rfc1337" = 1;

    # Force ARP respond on same interface
    # https://serverfault.com/questions/834512/why-does-linux-answer-to-arp-on-incorrect-interfaces
    # But do not set all or *
    # https://serverfault.com/questions/935366/why-does-arp-ignore-1-break-arp-on-pointopoint-interfaces-kvm-guest
    "net.ipv4.conf.all.arp_ignore" = 0;
    "net.ipv4.conf.default.arp_ignore" = 1;
    "net.ipv4.conf.all.arp_announce" = 0;
    "net.ipv4.conf.default.arp_announce" = 2;
  };
}
