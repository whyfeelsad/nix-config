{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
  in {
    "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

    "XF86AudioRaiseVolume".action = set-volume "5%+";
    "XF86AudioLowerVolume".action = set-volume "5%-";

    "Print".action = screenshot-screen;
    "Mod+Shift+Alt+S".action = screenshot-window;
    "Mod+Shift+S".action = screenshot;

    "Mod+D".action = spawn "fuzzel";
    "Mod+Return".action = spawn "kitty";
    "Ctrl+Alt+L".action = spawn "hyprlock";
    "Mod+U".action = spawn "env XDG_CURRENT_DESKTOP=gnome gnome-control-center";

    "Mod+Q".action = close-window;
    "Mod+R".action = switch-preset-column-width;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+Space".action = toggle-window-floating;

    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;
    "Mod+C".action = center-window;
    "Mod+Tab".action = switch-focus-between-floating-and-tiling;

    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Plus".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Plus".action = set-window-height "+10%";

    "Mod+H".action = focus-column-left;
    "Mod+J".action = focus-window-down;
    "Mod+K".action = focus-window-up;
    "Mod+L".action = focus-column-right;
    "Mod+Left".action = focus-column-left;
    "Mod+Down".action = focus-window-down;
    "Mod+Up".action = focus-window-up;
    "Mod+Right".action = focus-column-right;

    "Mod+Shift+H".action = move-column-left;
    "Mod+Shift+J".action = move-window-down;
    "Mod+Shift+K".action = move-window-up;
    "Mod+Shift+L".action = move-column-right;
  };
}
