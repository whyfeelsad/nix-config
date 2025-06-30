{
  lib,
  pkgs,
  ...
}: {
  nix = {
    # remove nix-channel related tools & configs, we use flakes instead.
    channel.enable = false;

    # auto upgrade nix to the unstable version
    package = pkgs.nixVersions.latest;

    # do garbage collection weekly to keep disk usage low
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };

    settings = {
      # Manual optimise storage: nix-store --optimise
      # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
      auto-optimise-store = true;

      # Enable flakes permanently in NixOS
      # https://nixos.wiki/wiki/Flakes
      experimental-features = ["nix-command" "flakes"];

      substituters = ["https://cache.garnix.io"];
      trusted-public-keys = ["cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="];
    };
  };

  # to install chrome, you need to enable unfree packages
  nixpkgs.config.allowUnfree = lib.mkForce true;
}
