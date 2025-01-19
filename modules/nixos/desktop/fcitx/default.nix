{pkgs, ...}: {
  i18n = {
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-rime
          fcitx5-configtool
          fcitx5-pinyin-zhwiki
          fcitx5-pinyin-moegirl
          fcitx5-chinese-addons
        ];
      };
    };
  };
}
