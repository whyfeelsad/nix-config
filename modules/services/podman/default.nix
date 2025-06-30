{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.podman;
  myvars = import ../../../vars;
  userName = myvars.userName;
in {
  options.modules.podman = {
    enable = lib.mkEnableOption "Enable Podman service";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dive
      podman-tui
      docker-compose
    ];

    virtualisation = {
      docker.enable = lib.mkForce false;
      podman = {
        enable = true;
        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;
        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
        # Periodically prune Podman resources
        autoPrune = {
          enable = true;
          dates = "weekly";
          flags = ["--all"];
        };
      };

      oci-containers = {
        backend = "podman";
      };
    };

    users.users.${userName}.extraGroups = ["podman"];
  };
}
