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
    ./packages
  ];

  home = {
    username = "${userName}";
    homeDirectory = "/home/${userName}";
    stateVersion = "${stateVersion}";
  };

  programs.home-manager.enable = true;
}
