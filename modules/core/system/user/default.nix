{ config, ... }:
let
  inherit (config.globals) userName sshAuthorizedKeys defaultHashedPassword;
in
{
  # Don't allow mutation of users outside the config.
  users.mutableUsers = false;

  users.users = {
    root = {
      hashedPassword = defaultHashedPassword;
      openssh.authorizedKeys.keys = sshAuthorizedKeys;
    };
    ${userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      hashedPassword = defaultHashedPassword;
      openssh.authorizedKeys.keys = sshAuthorizedKeys;
    };
  };

  preservation'.user.directories = [
    # XDG Directories
    "Downloads"
    "Music"
    "Pictures"
    "Documents"
    "Videos"

    # Nix / Home Manager Profiles
    ".cache/nix"
    ".local/share/nix"
    ".local/state/nix"
    ".local/state/home-manager"
    "nix-config"

    # Security
    {
      directory = ".ssh";
      mode = "0700";
    }
    {
      directory = ".gnupg";
      mode = "0700";
    }
  ];
}
