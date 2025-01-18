{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    blueberry
    bluez
    bluez-tools
    bluez-alsa
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
}
