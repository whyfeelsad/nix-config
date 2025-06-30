{
  lib,
  myvars,
  config,
  inputs,
  ...
}: let
  cfg = config.modules.preservation;
in {
  imports = [
    inputs.preservation.nixosModules.default
  ];

  options.modules.preservation = {
    enable = lib.mkEnableOption "preservation";
  };

  config = lib.mkIf cfg.enable {
    preservation = {
      enable = true;
      preserveAt."/persistent" = {
        directories = import ./dirs/common-system-dirs.nix;
        files = [
          # auto-generated machine ID
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
        ];

        users = {
          "${myvars.userName}" = {
            commonMountOptions = [
              "x-gvfs-hide"
            ];
            directories =
              (import ./dirs/common-home-dirs.nix)
              ++ (import ./dirs/common-home-special-dirs.nix)
              ++ (import ./dirs/common-misc-dirs.nix)
              ++ (import ./dirs/common-xdg-dirs.nix);

            files =
              import ./files/common-home-files.nix;
          };
        };
      };
    };

    # A work round for systemd-machine-id-commit.
    # See github:nixos/nixpkgs#351151 and issues in preservation and
    # impermanence.
    systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];

    # let the service commit the transient ID to the persistent volume
    systemd.services.systemd-machine-id-commit = {
      unitConfig.ConditionPathIsMountPoint = [
        ""
        "/persistent/etc/machine-id"
      ];
      serviceConfig.ExecStart = [
        ""
        "systemd-machine-id-setup --commit --root /persistent"
      ];
    };
  };
}
