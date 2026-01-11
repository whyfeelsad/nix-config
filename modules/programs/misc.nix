{ pkgs, ... }:
{
  hm' = {
    home.packages = with pkgs; [
      # 开发与编辑
      gh
      just
      git
      git-lfs
      lazygit
      neovim

      # 查找与导航
      fd
      fzf

      # 文本与数据处理
      jq
      gawk
      gnused
      gnugrep

      # 网络与下载
      curl
      wget

      # 磁盘与分析
      duf
      ncdu
      dust

      # 监控与诊断
      btop
      nmap
      socat
      fastfetch
    ];
  };
}
