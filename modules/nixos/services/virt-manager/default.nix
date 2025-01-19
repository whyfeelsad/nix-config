{
  pkgs,
  user,
  ...
}: {
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf = {
          packages = [pkgs.OVMFFull.fd];
          enable = true;
        };
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  networking.firewall.trustedInterfaces = ["virbr0"];

  environment = {
    systemPackages = with pkgs; [win-virtio];
    sessionVariables.LIBVIRT_DEFAULT_URI = ["qemu:///system"];
  };
}
