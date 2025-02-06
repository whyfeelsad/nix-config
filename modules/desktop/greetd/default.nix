{
  lib,
  pkgs,
  myvars,
  ...
}: {
  services = {
    greetd = {
      enable = true;
      vt = 2;
      settings = rec {
        initial_session = {
          command = "${pkgs.niri}/bin/niri-session";
          user = "${myvars.userName}";
        };
        default_session = initial_session;
      };
    };
  };
}
