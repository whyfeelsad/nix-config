{
  lib,
  pkgs,
  ...
}: let
  myvars = import ../../../vars;
in {
  services = {
    greetd = {
      enable = true;
      vt = 2;
      settings = rec {
        initial_session = {
          command = "niri-session";
          user = "${myvars.userName}";
        };
        default_session = initial_session;
      };
    };
  };
}
