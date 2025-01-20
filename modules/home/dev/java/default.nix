{pkgs, ...}: {
  home.packages = with pkgs; [
    # echo (readlink -f $(which java) | sed 's:/bin/java::')
    jdk8
  ];
}
