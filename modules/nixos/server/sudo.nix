{myvars, ...}: {
  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = ["${myvars.userName}"];
        commands = [
          {
            command = "/run/current-system/sw/bin/nix";
            options = ["NOPASSWD"];
          }
          {
            command = "/run/current-system/sw/bin/nixos-rebuild";
            options = ["NOPASSWD"];
          }
          {
            command = "/run/current-system/sw/bin/nix-collect-garbage";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };
}
