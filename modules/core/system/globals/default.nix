{ lib, ... }:
{
  options.globals = {
    userName = lib.mkOption {
      type = lib.types.str;
      default = "aaron";
      example = "aaron";
      description = "Default user name";
    };
    homeDirectory = lib.mkOption {
      type = lib.types.str;
      default = "/home/aaron";
      example = "/home/aaron";
      description = "Path of user home directory";
    };
    configDirectory = lib.mkOption {
      type = lib.types.str;
      default = "/home/aaron/nix-config";
      example = "/home/aaron/nix-config";
      description = "Path of config directory";
    };
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Asia/Singapore";
      example = "Asia/Singapore";
      description = "Time zone";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "niceboy@duck.com";
      example = "niceboy@example.com";
      description = "Email address";
    };
    defaultHashedPassword = lib.mkOption {
      type = lib.types.str;
      default = "$7$CU..../....mTYw28fnKaMzRRszVZhR21$tYH1/Z7DDGft7oGc67h61EBTXZ6JXbuzHJNIYmvYhV1";
      description = "Hashed password";
    };
    sshAuthorizedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHjMAQUXfyMv8TG1NfqjmQJG3gqZkh25KAvAMvxVrWS Aaron@MacBook-Pro"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA6xNNhF6jaPKuch8vSHwHTGlbyn4i2zSHxrqGOiacxG Aaron@Deployment"
      ];
      example = [ "ssh-rsa ABCDE... user@host" ];
      description = "List of SSH public keys authorized for the primary user.";
    };
  };
}
