{pkgs, ...}: {
  hm' = {
    home.packages = with pkgs; [
      # === 压缩工具 ===
      zip
      xz
      zstd
      unzipNLS
      p7zip

      # === 文件查找与导航 ===
      fd # 更快的 find 替代品
      fzf # 命令行模糊查找

      # === 开发工具 ===
      just # 命令运行器
      lazygit # Git TUI
      alejandra # Nix 格式化

      # === 磁盘与文件分析 ===
      duf # 磁盘使用（彩色直观）
      ncdu # 磁盘占用（交互式清理）
      dust # du 替代品（更直观）

      # === 监控工具 ===
      bottom # 进程监控（跨平台）
      gping # 图形化 ping

      # === 文本处理 ===
      jq # JSON 处理
      gawk # awk
      gnused # sed
      gnugrep # grep
    ];
  };

  environment.systemPackages = with pkgs; [
    # === 基础工具 ===
    git
    git-lfs
    lsof
    which
    psmisc
    rsync
    openssl

    # === 系统监控 ===
    btop # 资源监控（htop 升级版）
    htop # 进程监控
    iotop # I/O 监控
    nload # 网络负载监控
    iftop # 网络带宽监控
    strace # 系统调用跟踪
    sysstat # 系统性能工具集
    tailspin # tail -f 升级版
    bpftrace # eBPF 跟踪工具
    fastfetch # 系统信息获取

    # === 网络工具 ===
    mtr # traceroute + ping 组合
    curl
    wget
    nmap # 端口扫描
    socat # 多用途数据转发器
    ipcalc # IP 计算器
    iperf3 # 网络性能测试
    tcpdump # 数据包捕获
    dnsutils # DNS 工具（dig, nslookup）
  ];
}
