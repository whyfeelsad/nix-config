###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#  Incomplete list of macOS `defaults` commands :
#    https://github.com/yannbertrand/macos-defaults
#
###################################################################################

{ config, ... }:
{
  # Set your time zone.
  time.timeZone = config.core'.timeZone;

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    stateVersion = 6;

    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock
      menuExtraClock.ShowSeconds = true;

      # customize dock
      dock = {
        autohide = true; # 自动隐藏 Dock
        show-recents = false; # 禁用最近应用

        # 触发角
        wvous-tl-corner = 2; # Mission Control
        wvous-tr-corner = 4; # Desktop
        wvous-bl-corner = 3; # Application Windows
        wvous-br-corner = 13; # Lock Screen
      };

      finder = {
        _FXShowPosixPathInTitle = true; # 显示Finder标题中的完整路径
        AppleShowAllExtensions = true; # 显示所有文件扩展名
        FXEnableExtensionChangeWarning = false; # 更改文件扩展名时禁用警告
        QuitMenuItem = true; # 启用退出菜单项
        ShowPathbar = true; # 显示路径栏
        ShowStatusBar = true; # 显示状态栏
      };

      trackpad = {
        Clicking = true; # 是否启用点击
        TrackpadRightClick = true; # 启用两指右键点击
        TrackpadThreeFingerDrag = true; # 是否启用三指拖动
      };

      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = true; # 启用自然滚动（默认为true）
        "com.apple.sound.beep.feedback" = 0; # 系统音量改变时发出反馈声音。

        # Appearance
        AppleInterfaceStyle = "Dark"; # 深色模式

        AppleKeyboardUIMode = 2; # 配置键盘控制行为

        InitialKeyRepeat = 15; # 正常最小值为15（225毫秒），最大值为120（1800毫秒）
        KeyRepeat = 3; # 正常最小值为2（30毫秒），最大值为120（1800毫秒）

        NSAutomaticCapitalizationEnabled = false; # 是否启用自动大写
        NSAutomaticDashSubstitutionEnabled = false; # 是否启用智能减号替换
        NSAutomaticPeriodSubstitutionEnabled = false; # 是否启用智能句号替换
        NSAutomaticQuoteSubstitutionEnabled = false; # 是否启用智能引号替换
        NSAutomaticSpellingCorrectionEnabled = false; # 是否启用自动拼写检查
        NSNavPanelExpandedStateForSaveMode = true; # 保存文件时的路径选择/文件名输入页
        NSNavPanelExpandedStateForSaveMode2 = true; # 保存文件时的路径选择/文件名输入页
      };

      # Customize settings that not supported by nix-darwin directly
      # see the source code of this project to get more undocumented options:
      #    https://github.com/rgcr/m-cli
      #
      # All custom entries can be found by running `defaults read` command.
      # or `defaults read xxx` to read a specific domain.
      CustomUserPreferences = {
        ".GlobalPreferences" = {
          # automatically switch to a new space when switching to the application
          AppleSpacesSwitchOnActivate = true;
        };
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.spaces" = {
          "spans-displays" = 0; # Display have seperate spaces
        };
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = 0; # Click wallpaper to reveal desktop
          StandardHideDesktopIcons = 0; # Show items on desktop
          HideDesktop = 0; # Do not hide items on desktop & stage manager
          StageManagerHideWidgets = 0;
          StandardHideWidgets = 0;
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.screencapture" = {
          location = "~/Desktop";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;
      };
    };
  };
}
