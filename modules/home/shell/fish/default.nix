{
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -l --color=auto";
      la = "ls -la --color=auto";
      ls = "ls --color=auto";
      grep = "grep --color=auto";
    };
    interactiveShellInit = ''
      # Disable the greeting message.
      set fish_greeting
      starship init fish | source
    '';
  };
}
