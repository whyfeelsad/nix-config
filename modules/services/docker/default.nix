{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.modules.docker;
  myvars = import ../../../vars;
  userName = myvars.userName;
in
{
  options.modules.docker = {
    enable = lib.mkEnableOption "Enable Docker service";
  };

  config = lib.mkIf cfg.enable {
    # enable docker
    virtualisation = {
      podman.enable = lib.mkForce false;
      docker = {
        enable = true;
        enableOnBoot = true;
        storageDriver = "btrfs";
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
        extraOptions = "--iptables=false --ip6tables=false";
      };
    };

    # Useful other development tools
    environment.systemPackages = with pkgs; [
      dive # look into docker image layers
      docker-compose # start group of containers for dev
      lazydocker # Docker terminal UI.
    ];

    users.users.${userName}.extraGroups = [ "docker" ];
  };
}
