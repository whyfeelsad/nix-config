{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.services'.podman;
  user = config.core'.userName;
in {
  options.services'.podman = {
    enable = lib.mkEnableOption "Enable Podman container engine";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = ["--all"];
      };
    };

    # Useful other development tools
    environment.systemPackages = with pkgs; [
      dive
      podman-tui
    ];

    users.users.${user}.extraGroups = ["podman"];

    preservation'.os.directories = [
      "/var/lib/containers"
    ];
  };
}
