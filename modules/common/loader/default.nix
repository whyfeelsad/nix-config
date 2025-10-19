{ lib, ... }:
{
  imports = [
    ./grub
    ./systemd-boot
  ];

  boot.loader.timeout = lib.mkDefault 1;
}
