{pkgs, ...}: {
  home.packages = with pkgs; [
    tldr # Simplified and community-driven man pages

    fd # Simple, fast and user-friendly alternative to find
    fzf # Command-line fuzzy finder written in Go

    just # Handy way to save and run project-specific commands
    lazygit # Simple terminal UI for git commands
    gping # Ping, but with a graph
    duf # Disk Usage/Free Utility
    gdu # Disk usage analyzer with console interface
    ncdu # Disk usage analyzer with an ncurses interface
    du-dust # Like du but more intuitive
    alejandra # Uncompromising Nix Code Formatter
  ];

  programs = {
    # A modern replacement for ‘ls’
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };

    zoxide = {
      enable = true;
    };

    atuin = {
      enable = true;
    };
  };
}
