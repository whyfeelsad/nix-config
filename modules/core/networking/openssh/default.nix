{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.networking'.openssh;
in
{
  options.networking'.openssh = {
    enable = lib.mkEnableOption "Enable the OpenSSH daemon";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      sshfs
      sshs
    ];

    services.openssh = {
      enable = true;
      ports = [ 233 ];
      settings = {
        # root user is used for remote deployment, so we need to allow it
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false; # disable password login
      };
      openFirewall = true;
    };

    # Add terminfo database of all known terminals to the system profile.
    # https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/config/terminfo.nix
    environment.enableAllTerminfo = true;
  };
}
