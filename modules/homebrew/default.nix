{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      cleanup = "zap"; # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      Bob = 1630034110;
      Wechat = 836500024;
    };

    # `brew install`
    brews = [
      "opencode"
    ];

    # `brew install --cask`
    casks = [
      "claude-code"
      "visual-studio-code"
      "telegram"
      "qspace-pro"
      "surge"

      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-maple-mono-nf-cn"
      "font-material-icons"
      "font-lxgw-wenkai"
    ];
  };
}
