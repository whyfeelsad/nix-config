{
  # required by impermanence
  fileSystems."/persistent".neededForBoot = true;

  disko.devices = {
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "relatime"
          "nosuid"
          "nodev"
          "size=4G"
          "mode=755"
        ];
      };
    };

    disk = {
      nvme = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                extraArgs = [
                  "-n"
                  "BOOT"
                ];
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            # The root partition
            # systemd-cryptenroll --fido2-device=auto --fido2-with-user-presence=true --fido2-with-user-verification=false --fido2-with-client-pin=false /dev/nvme0n1p2
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
                    "fido2-device=auto"
                    "token-timeout=10"
                  ];
                };

                # Whether to add a boot.initrd.luks.devices entry for the specified disk.
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
                      mountOptions = [
                        "compress-force=zstd"
                        "noatime"
                        "discard=async"
                        "space_cache=v2"
                        "nodev"
                        "nosuid"
                      ];
                    };
                    "@persistent" = {
                      mountpoint = "/persistent";
                      mountOptions = [
                        "compress-force=zstd"
                        "noatime"
                        "discard=async"
                        "space_cache=v2"
                      ];
                    };
                    # it will be used by btrbk to create snapshots
                    "@snapshots" = {
                      mountpoint = "/snapshots";
                      mountOptions = [
                        "compress-force=zstd"
                        "noatime"
                        "discard=async"
                        "space_cache=v2"
                      ];
                    };
                    "@tmp" = {
                      mountpoint = "/tmp";
                      mountOptions = [
                        "relatime"
                        "nodev"
                        "nosuid"
                        "discard=async"
                        "space_cache=v2"
                      ];
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
