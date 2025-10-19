{ inputs, pkgs, ... }:
{
  programs = {
    # Atuin replaces your existing shell history with a SQLite database,
    # and records additional context for your commands.
    # Additionally, it provides optional and fully encrypted
    # synchronisation of your history between machines, via an Atuin server.
    atuin = {
      enable = true;
      package = inputs.atuin.packages.${pkgs.system}.default;
      enableBashIntegration = true;
      enableFishIntegration = true;
      daemon.enable = true;
      settings = {
        sync_frequency = 0;
        inline_height = 20;
        history_filter = [
          ''^ls($|(\s+((-([a-zA-Z0-9]|-)+)|"(\.|[^/])[^"]*"|'(\.|[^/])[^']*'|(\.|[^/\s-])[^\s]*))*\s*$)'' # filter ls command with non-absolute pathes
          ''^cd($|\s+('[^/][^']*'|"[^/][^"]*"|[^/\s'"][^\s]*))$'' # filter cd command with non-absolute pathes
          ''/nix/store/.*'' # command contains /nix/store
          ''--cookie[=\s]+.+'' # command contains cookie
        ];
      };
    };
  };
}
