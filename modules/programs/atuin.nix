{
  hm'.programs = {
    atuin = {
      enable = true;
      enableZshIntegration = true;
      daemon.enable = true;
      settings = {
        sync_frequency = 0;
        inline_height = 30;
        history_filter = [
          ''^ls($|(\s+((-([a-zA-Z0-9]|-)+)|"(\.|[^/])[^"]*"|'(\.|[^/])[^']*'|(\.|[^/\s-])[^\s]*))*\s*$)'' # filter ls command with non-absolute pathes
          ''^cd($|\s+('[^/][^']*'|"[^/][^"]*"|[^/\s'"][^\s]*))$'' # filter cd command with non-absolute pathes
          "/nix/store/.*" # command contains /nix/store
          ''--cookie[=\s]+.+'' # command contains cookie
        ];
      };
    };
  };
}
