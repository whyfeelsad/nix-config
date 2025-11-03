{ lib, config, ... }:
let
  inherit (config.globals) userName homeDirectory email;
in
{
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  hm'.home.activation.removeExistingGitconfig = ''
    rm -f ${homeDirectory}/.gitconfig
  '';

  hm'.programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = userName;
          email = email;
        };
      };
    };

    delta = {
      enable = true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        true-color = "always";
      };
    };
  };
}
