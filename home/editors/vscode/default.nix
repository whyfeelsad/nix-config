{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = (
      pkgs.vscode.override {
        commandLineArgs = "--ozone-platform=wayland";
      }
    );
  };
}
