{
  lib,
  inputs,
  config,
  ...
}:
let
  cfg = config.hardware'.preservation;
  inherit (config.globals) userName;
in
{
  imports = [
    inputs.preservation.nixosModules.default

    (lib.mkAliasOptionModule [ "preservation'" "os" ] [ "preservation" "preserveAt" "/persistent" ])
    (lib.mkAliasOptionModule
      [ "preservation'" "user" ]
      [ "preservation" "preserveAt" "/persistent" "users" userName ]
    )
  ];

  options.hardware'.preservation = {
    enable = lib.mkEnableOption "Enable Data Persistence";
  };

  config = lib.mkIf cfg.enable {
    boot.tmp.cleanOnBoot = true;

    preservation = {
      enable = true;
      preserveAt."/persistent" = {
        commonMountOptions = [
          "x-gvfs-hide"
          "x-gdu.hide"
        ];
        directories = [
          "/var/lib/systemd"
          "/var/log"
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
          {
            directory = "/var/lib/machines";
            mode = "0700";
          }
          {
            directory = "/var/lib/private";
            mode = "0700";
          }
        ];
        files = [
          # auto-generated machine ID
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
        ];
      };
    };

    # systemd-machine-id-commit.service would fail, but it is not relevant
    # in this specific setup for a persistent machine-id so we disable it
    #
    # see the firstboot example below for an alternative approach
    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

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
