{ lib, config, ... }:
let
  cfg = config.networking'.networkmanager;
in
{
  options.networking'.networkmanager = {
    enable = lib.mkEnableOption "Enable the networkmanager";
  };

  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = lib.mkDefault true;
      };
    };
    user'.extraGroups = [ "networkmanager" ];
    preservation'.os.directories = [
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];
  };
}
