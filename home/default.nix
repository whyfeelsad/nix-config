{
  myvars,
  ...
}:
let
  userName = myvars.userName;
  stateVersion = myvars.stateVersion;
in
{
  imports = [
    ./apps
    ./desktop
    ./packages
  ];

  home = {
    username = "${userName}";
    homeDirectory = "/home/${userName}";
    stateVersion = "${stateVersion}";
  };

  programs.home-manager.enable = true;
}
