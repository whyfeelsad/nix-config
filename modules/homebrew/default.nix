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
      ServerCat = 1501532023;
    };

    # `brew install`
    brews = [
      "mole"
      "opencode"
    ];

    # `brew install --cask`
    casks = [
      # 开发工具 & 终端 (Development)
      "zed"
      "termius"
      "orbstack"
      "lm-studio"
      "claude-code"
      "visual-studio-code"
      "android-platform-tools"

      # 系统增强 & 效能 (Productivity)
      "stats"
      "raycast"
      "qspace-pro"
      "squirrel-app"
      "monitorcontrol"
      "macs-fan-control"
      "input-source-pro"
      "karabiner-elements"
      "jordanbaird-ice@beta"

      # 电池管理 (Battery)
      "battery"
      "battery-buddy"

      # 网络与通讯 (Network)
      "surge"
      "telegram"
      "brave-browser"
      "google-chrome"

      # 媒体播放 (Media)
      "iina"
      "neteasemusic"

      # 字体 (Fonts)
      "font-lxgw-wenkai"
      "font-material-icons"
      "font-hack-nerd-font"
      "font-maple-mono-nf-cn"
      "font-jetbrains-mono-nerd-font"
    ];
  };
}
