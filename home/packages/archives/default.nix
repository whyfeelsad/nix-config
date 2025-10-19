{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zip
    xz
    zstd
    unzipNLS
    p7zip
  ];
}
