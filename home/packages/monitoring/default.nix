{pkgs, ...}: {
  home.packages = with pkgs; [
    bottom # process
    ncdu # disk utilization
    duf # disk usage analyzer
    gdu # Disk usage analyzer with console interface
    du-dust # Like du but more intuitive
    gping # Ping, but with a graph
  ];
}
