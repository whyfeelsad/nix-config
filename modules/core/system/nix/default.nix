{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./nh.nix
    ./substituters.nix
  ];

  environment.systemPackages = with pkgs; [
    alejandra
    comma
    deadnix
    nil
    nix-index
    nix-output-monitor
    nix-prefetch-git # get fetchgit hashes
    nix-prefetch-github
    nix-serve # create a local nix cachix like server
    nix-tree
    nixpkgs-review
    nurl # get fetchgit hashes
    nvd
  ];

  nix = {
    # remove nix-channel related tools & configs, we use flakes instead.
    channel.enable = false;

    # do garbage collection weekly to keep disk usage low
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [
        "@wheel"
      ];
    };
  };

  programs.command-not-found.enable = true;

  # to install chrome, you need to enable unfree packages
  nixpkgs.config.allowUnfree = lib.mkForce true;
}
