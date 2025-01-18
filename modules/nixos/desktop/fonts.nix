{pkgs, ...}: {
  # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      # emoji
      noto-fonts-emoji

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-24.11/pkgs/data/fonts/nerdfonts/shas.nix
      (nerdfonts.override {
        fonts = [
          # symbols icon only
          "NerdFontsSymbolsOnly"
          # Characters
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
        ];
      })
      maple-mono-NF

      # chinese fonts
      source-han-sans
      source-han-serif
      lxgw-wenkai
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [
          "Noto Color Emoji"
        ];
        serif = [
          "Source Han Serif SC"
          "Source Han Serif TC"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Source Han Sans SC"
          "Source Han Sans TC"
          "Noto Color Emoji"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "Noto Color Emoji"
        ];
      };
    };
  };
}
