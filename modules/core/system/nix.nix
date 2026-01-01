{
  lib,
  pkgs,
  config,
  ...
}:
let
  user = config.core'.userName;
in
{
  environment.systemPackages = with pkgs; [
    comma
    deadnix
    nil
    nixd
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
      substituters = [
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };
  };

  # to install chrome, you need to enable unfree packages
  nixpkgs.config.allowUnfree = lib.mkForce true;

  preservation'.user.directories = [
    ".local/state/home-manager"
    ".local/state/nix/profiles"
    ".local/share/nix"
    ".cache/nix"
    ".cache/nixpkgs-review"
  ];

  hm'.programs.nh = {
    enable = true;
    flake = "/home/${user}/nix-config";
    clean = {
      enable = true;
      extraArgs = "--keep 5";
    };
  };
}
