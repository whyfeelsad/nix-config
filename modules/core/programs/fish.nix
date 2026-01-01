{pkgs, ...}: {
  programs.fish = {
    enable = true;
    useBabelfish = true;
    shellInit = ''
      set -U fish_greeting
      fish_vi_key_bindings
    '';
  };

  user'.shell = pkgs.fish;

  hm'.programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Atuin shell history with fish fix for "bind -k up" issue
      # https://github.com/atuinsh/atuin/issues/2803
      ${pkgs.atuin}/bin/atuin init fish | sed 's/-k up/up/' | source
    '';
  };

  preservation'.user.directories = [
    ".cache/fish"
    ".config/fish"
    ".local/share/fish"
  ];
}
