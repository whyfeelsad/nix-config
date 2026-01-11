{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.core';
in {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    (lib.mkAliasOptionModule ["hm'"] ["home-manager" "users" cfg.userName])
  ];

  options.core' = {
    userName = lib.mkOption {
      type = lib.types.str;
      description = "Login user name";
    };
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "Network hostname";
    };
    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "26.05";
      description = "NixOS state version";
    };

  };

  config = {
    system.primaryUser = cfg.userName;

    networking.hostName = cfg.hostName;
    networking.computerName = cfg.hostName;
    system.defaults.smb.NetBIOSName = cfg.hostName;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-bak";

      users.${cfg.userName} = {
        home.stateVersion = cfg.stateVersion;
        home.homeDirectory = lib.mkForce "/Users/${cfg.userName}";
      };
    };
  };
}
