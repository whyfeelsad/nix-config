{
  lib,
  pkgs,
  ...
}: {
  boot'.grub.enable = true;
  boot'.initrd-ssh.enable = true;

  hardware'.qemu.enable = true;
  hardware'.disable-balloon.enable = true;
  hardware'.disko-luks.enable = true;
  hardware'.disko-luks.device = "/dev/vda";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "ip=dhcp"
      "audit=0"
      "net.ifnames=0"
    ];

    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  zramSwap = {
    enable = true;
    priority = 5;
    algorithm = "zstd";
    memoryPercent = 500;
    memoryMax = 2 * 1024 * 1024 * 1024 + (1024 * 1024);
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
