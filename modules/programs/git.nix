{
  hm'.programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = "Aaron";
          email = "niceboy@duck.com";
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
