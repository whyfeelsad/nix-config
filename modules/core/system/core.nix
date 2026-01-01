{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.core';
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (lib.mkAliasOptionModule ["user'"] ["users" "users" cfg.userName])
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
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Asia/Singapore";
      description = "System timezone";
    };
    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "26.05";
      description = "NixOS state version";
    };
    sshKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHjMAQUXfyMv8TG1NfqjmQJG3gqZkh25KAvAMvxVrWS Aaron@MacBook-Pro"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA6xNNhF6jaPKuch8vSHwHTGlbyn4i2zSHxrqGOiacxG Aaron@Deployment"
      ];
      example = ["ssh-ed25519 AAAA..."];
      description = "SSH public keys for the main user";
    };
  };

  config = {
    sops.secrets.hashedPassword = {
      sopsFile = ../../secrets/password.yaml;
      neededForUsers = true;
    };

    users.mutableUsers = false;
    users.users = {
      root = {
        hashedPasswordFile = config.sops.secrets.hashedPassword.path;
        openssh.authorizedKeys.keys = cfg.sshKeys;
      };
      ${cfg.userName} = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        hashedPasswordFile = config.sops.secrets.hashedPassword.path;
        openssh.authorizedKeys.keys = cfg.sshKeys;
      };
    };

    networking.hostName = cfg.hostName;
    time.timeZone = cfg.timeZone;
    system.stateVersion = cfg.stateVersion;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-bak";
    };

    home-manager.users.${cfg.userName} = {
      home.stateVersion = cfg.stateVersion;
      xdg.enable = true;
    };
  };
}
