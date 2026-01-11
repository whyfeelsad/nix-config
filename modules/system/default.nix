###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#  Incomplete list of macOS `defaults` commands :
#    https://github.com/yannbertrand/macos-defaults
#
###################################################################################

{ config, ... }:
{
  # Set your time zone.
  time.timeZone = config.core'.timeZone;

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    stateVersion = 6;

    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock
      menuExtraClock.ShowSeconds = true;
    };
  };
}
