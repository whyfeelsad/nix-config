{
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.modules.disko-vda;
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  options.modules.disko-vda = {
    enable = lib.mkEnableOption "Enable disko configuration for vda disk";
  };

  config = lib.mkIf cfg.enable {
    # required by impermanence
    fileSystems."/persistent".neededForBoot = true;

    disko.devices = {
      nodev = {
        "/" = {
          fsType = "tmpfs";
          mountOptions = [
            "nodev"
            "nosuid"
            "relatime"
            "mode=755"
          ];
        };
      };

      disk = {
        vda = {
          type = "disk";
          device = "/dev/vda";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "1M";
                type = "EF02";
                priority = 0;
              };
              ESP = {
                size = "256M";
                type = "EF00";
                priority = 1;
                content = {
                  type = "filesystem";
                  extraArgs = ["-n" "BOOT"];
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["umask=0077"];
                };
              };
              nix = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-f"
                    "--csum xxhash64"
                    "--label NixOS"
                  ];
                  subvolumes = {
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "@persistent" = {
                      mountpoint = "/persistent";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "@snapshots" = {
                      mountpoint = "/snapshots";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "@tmp" = {
                      mountpoint = "/tmp";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
