{myvars, ...}: {
  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      "/etc/ssh"
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"

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

        ".config/fcitx5"
        ".local/share/atuin"
        ".local/share/fcitx5"
        ".local/share/fish"
        ".local/share/materialgram"
        ".local/share/zoxide"

        ".local/share/keyrings"

        ".mozilla"
        ".cache/mozilla"
        ".wakatime"

        ".config/Bitwarden"
        ".cache/com.bitwarden.desktop"

        # Vscode
        ".config/Code"

        ".lingma"

        # JetBrains
        ".config/JetBrains"
        ".cache/JetBrains"
        ".local/share/JetBrains"

        ".npm"
        ".java"
      ];
      files = [".wakatime.cfg"];
    };
  };
}
