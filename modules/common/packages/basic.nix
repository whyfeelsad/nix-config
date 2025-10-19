{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    git-lfs
    wget
    lsof
    which
    psmisc
    rsync
    openssl
  ];
}
