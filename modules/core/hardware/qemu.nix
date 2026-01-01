{
  lib,
  config,
  ...
}: let
  cfg = config.hardware'.qemu;
in {
  options.hardware'.qemu = {
    enable = lib.mkEnableOption "Enable QEMU initrd configuration";
  };

  config = lib.mkIf cfg.enable {
    boot.initrd = {
      availableKernelModules = [
        "virtio_net"
        "virtio_pci"
        "virtio_mmio"
        "virtio_blk"
        "virtio_scsi"
      ];

      kernelModules = [
        "virtio_console"
        "virtio_rng"
      ];

      compressor = "zstd";
      compressorArgs = [
        "-19"
        "-T0"
      ];

      systemd.enable = true;
    };
  };
}
