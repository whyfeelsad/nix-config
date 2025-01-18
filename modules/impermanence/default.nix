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

        ".local/share/flatpak"
        ".var/app"
        ".config/fcitx5"
        ".config/fish"

        ".npm"
        ".java"

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
