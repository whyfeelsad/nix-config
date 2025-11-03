{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    useBabelfish = true;
    shellInit = ''
      set -U fish_greeting
      fish_vi_key_bindings
    '';
  };

  user'.shell = pkgs.fish;

  hm'.programs.fish.enable = true;

  preservation'.user.directories = [
    ".config/fish"
    ".local/share/fish"
  ];
}
