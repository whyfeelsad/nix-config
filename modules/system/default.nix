{ config, ... }:
{
  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # Set your time zone.
  time.timeZone = config.core'.timeZone;

  system = {
    stateVersion = 6;

    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock
    };
  };
}
