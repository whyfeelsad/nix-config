{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}:
{
  imports = [
    ./disko-fs.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [
      "ext4"
      "btrfs"
      "xfs"
      "fat"
      "vfat"
      "cifs"
      "nfs"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      systemd.enable = true;
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
      ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];

    tmp = {
      # Clear /tmp on boot to get a stateless /tmp directory.
      cleanOnBoot = true;
      # Size of tmpfs in percentage.
      tmpfsSize = "20%"; # default "50%"
    };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Maintenance services
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/persistent" ];
  };
}
