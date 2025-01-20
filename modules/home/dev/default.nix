{ pkgs, ... }:
{

  imports = [
    ./java
    ./node
  ];

  home.packages = with pkgs; [
    nixfmt-rfc-style
  ];
}
