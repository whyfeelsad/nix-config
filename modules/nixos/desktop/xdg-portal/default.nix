{ pkgs, ... }:
{
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  programs.dconf = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    # sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1
    xdgOpenUsePortal = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      common.default = "*";
    };
  };
}
