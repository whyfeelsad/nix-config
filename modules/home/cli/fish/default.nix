{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -l --time-style long-iso";
      la = "eza -la --time-style long-iso";
      tree = "eza --tree";

      mvn = "/home/aaron/Documents/WorkSpace/apache-maven-3.8.4/bin/mvn";
    };
    interactiveShellInit = ''
      # Disable the greeting message.
      set fish_greeting
      starship init fish | source
    '';
  };
}
