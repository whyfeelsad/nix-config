{ lib, config, ... }:
let
  cfg = config.networking'.firewall;
in
{
  options.networking'.firewall = {
    enable = lib.mkEnableOption "Enable the firewall";
  };

  config = lib.mkIf cfg.enable {
    networking = {
      firewall = {
        enable = lib.mkDefault true;
        allowPing = lib.mkDefault true;
      };
      nftables.enable = lib.mkDefault true;
    };
  };
}
