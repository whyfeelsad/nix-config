{pkgs, ...}: {
  home.packages = with pkgs; [
    fd
    fzf
    just
    lazygit
    alejandra
  ];
}
