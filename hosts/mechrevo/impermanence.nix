{myvars, ...}: {
  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      "/etc/ssh"

      "/var/log"
      "/var/lib"
    ];
    files = [];

    users."${myvars.userName}" = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"

        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".docker";
          mode = "0700";
        }

        ".local/share/fish"
        ".local/share/materialgram"

        ".config/fcitx5"

        ".npm"
        ".java"
        ".jdks"

        # JetBrains
        ".config/JetBrains"
        ".cache/JetBrains"
        ".local/share/JetBrains"

        # Vscode
        ".config/Code"
      ];
      files = [];
    };
  };
}
