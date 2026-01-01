{
  lib,
  config,
  ...
}: {
  options.boot'.initrd-ssh = {
    enable = lib.mkEnableOption "Enable SSH in initrd";

    port = lib.mkOption {
      type = lib.types.port;
      default = 22;
      description = "SSH port for initrd";
    };

    hostKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["/etc/secrets/initrd/id_ed25519"];
      description = "Host keys for initrd SSH";
    };
  };

  config = lib.mkIf config.boot'.initrd-ssh.enable {
    boot.initrd.network = {
      enable = true;
      ssh = {
        enable = true;
        port = config.boot'.initrd-ssh.port;
        hostKeys = config.boot'.initrd-ssh.hostKeys;
      };
    };

    boot.initrd.systemd.users.root.shell = "/bin/systemd-tty-ask-password-agent";

    preservation'.os.directories = [
      "/etc/secrets/initrd"
    ];
  };
}
