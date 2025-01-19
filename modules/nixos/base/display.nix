{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brightnessctl # This program allows you read and control device brightness
    ddcutil # Query and change Linux monitor settings using DDC/CI and USB
  ];
}
