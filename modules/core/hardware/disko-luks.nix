{
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.hardware'.disko-luks;
in {
  imports = [inputs.disko.nixosModules.disko];

  options.hardware'.disko-luks = {
    enable = lib.mkEnableOption "Enable LUKS encrypted disk";

    device = lib.mkOption {
      type = lib.types.str;
      example = "/dev/vda";
      description = "Disk device path";
    };
  };

  config = lib.mkIf cfg.enable {
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
            "size=500M"
          ];
        };
      };

      disk = {
        main = {
          type = "disk";
          device = cfg.device;
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "1M";
                type = "EF02";
                priority = 0;
              };
              esp = {
                size = "256M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  extraArgs = ["-n" "BOOT"];
                  mountOptions = ["umask=0077"];
                };
              };
              luks = {
                size = "100%";
                type = "8309";
                content = {
                  type = "luks";
                  name = "crypted";
                  settings = {
                    allowDiscards = true;
                    bypassWorkqueues = true;
                    crypttabExtraOpts = [
                      "same-cpu-crypt"
                      "submit-from-crypt-cpus"
                      "token-timeout=10"
                    ];
                  };
                  initrdUnlock = true;
                  content = {
                    type = "btrfs";
                    extraArgs = [
                      "-f"
                      "--csum xxhash64"
                      "--label NixOS"
                      "--features"
                      "block-group-tree"
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
  };
}
