{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  # required by preservation
  fileSystems."/persistent".neededForBoot = true;

  disko.devices = {
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
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
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                  bypassWorkqueues = true;
                  crypttabExtraOpts = [
                    "same-cpu-crypt"
                    "submit-from-crypt-cpus"
                  ];
                };

                # encrypt the root partition with luks2 and argon2id, will prompt for a passphrase, which will be used to unlock the partition.
                # cryptsetup luksFormat
                extraFormatArgs = [
                  "--type luks2"
                  "--cipher aes-xts-plain64"
                  "--hash sha512"
                  "--iter-time 5000"
                  "--key-size 256"
                  "--pbkdf argon2id"
                  # use true random data from /dev/random, will block until enough entropy is available
                  "--use-random"
                ];

                extraOpenArgs = [
                  "--timeout 10"
                ];

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
                    # mount the top-level subvolume at /btr_pool
                    # it will be used by btrbk to create snapshots
                    "/" = {
                      mountpoint = "/btr_pool";
                      # btrfs's top-level subvolume, internally has an id 5
                      # we can access all other subvolumes from this subvolume.
                      mountOptions = ["subvolid=5"];
                    };
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
                    "@swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "32769M";
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
