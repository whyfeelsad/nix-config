{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
    fuzzel
    firefox
    xwayland-satellite
  ];
}
