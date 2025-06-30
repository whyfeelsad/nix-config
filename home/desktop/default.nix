{pkgs, ...}: {
  imports = [
    ./cursor
    ./terminal
    ./packages
    ./waybar
  ];
}
