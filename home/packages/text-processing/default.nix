{pkgs, ...}: {
  home.packages = with pkgs; [
    # Docs: https://github.com/learnbyexample/Command-line-text-processing
    jq
    gawk
    gnused
    gnugrep
  ];
}
