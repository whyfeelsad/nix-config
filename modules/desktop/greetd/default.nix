{ myvars, ... }:
{
  services = {
    greetd = {
      enable = true;
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
