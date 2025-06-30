{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["ext4" "btrfs" "xfs" "fat" "vfat" "cifs" "nfs"];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      systemd.enable = true;
      availableKernelModules = ["nvme" "xhci_pci" "thunderbolt"];
      kernelModules = ["amdgpu" "i2c_dev" "iwlwifi" "iwlmvm"];
    };

    kernelModules = ["kvm-amd"];
    extraModulePackages = [];

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
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    # linux-firmware
    enableAllFirmware = true;

    # GPU (OpenGL)
    # Command to check the current Mesa version: glxinfo | grep "OpenGL version"
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        amdvlk # AMD Open Source Driver For Vulkan
        vaapiVdpau # VDPAU driver for the VAAPI library
        libvdpau-va-gl # VDPAU driver with OpenGL/VAAPI backend
        libdrm # Direct Rendering Manager library and headers
      ];
    };

    # CPU
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  # Extra hardware packages
  environment.systemPackages = with pkgs; [
    amdgpu_top # Tool to display AMDGPU usage
    dmidecode # A tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard
    libnotify # A library that sends desktop notifications to a notification daemon
    libva-utils # A collection of utilities and examples for VA-API
    cpufetch # Simplistic yet fancy CPU architecture fetching tool
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    glxinfo # Test utilities for OpenGL
    acpi # Show battery status and other ACPI information
  ];

  # Thunderbolt
  services.hardware.bolt.enable = true;

  # Maintenance services
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = ["/persistent"];
  };
}
