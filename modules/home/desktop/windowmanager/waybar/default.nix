{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = [
          "custom/nixlogo"
          "niri/workspaces"
          "cpu"
          "memory"
        ];
        modules-center = ["clock"];
        modules-right = [
          "tray"
          "network"
          "bluetooth"
          "backlight"
          "pulseaudio"
          "battery"
        ];

        # Logo
        "custom/nixlogo" = {
          format = "";
          tooltip = false;
          # on-click = "${pkgs.wofi}/bin/wofi --show drun";
        };

        # Workspaces
        "niri/workspaces" = {};

        # Cpu usage
        cpu = {
          interval = 5;
          tooltip = false;
          format = " {usage}%";
          format-alt = " {load}";

          states = {
            warning = 70;
            critical = 90;
          };
        };

        # Memory usage
        memory = {
          interval = 5;
          format = " {percentage}%";
          tooltip = " {used:0.1f}G/{total:0.1f}G";

          states = {
            warning = 70;
            critical = 90;
          };
        };

        # Clock & Calendar
        clock = {
          format = "  {:%m/%d %I:%M %p}";
          format-alt = "  {:%a, %d %b %Y}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
            actions = {
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
        };

        # Tray
        tray = {
          icon-size = 15;
          spacing = 8;
        };

        # Network
        network = {
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-wifi = "{icon}";
          format-ethernet = "󰈀";
          format-disconnected = "⚠";
          tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n {bandwidthUpBytes}  {bandwidthDownBytes}";
          tooltip-format-ethernet = "Ethernet: {ifname}\n {bandwidthUpBytes}  {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          interval = 5;
        };

        # Bluetooth
        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          on-click = "blueberry";
          interval = 5;
        };

        # Backlight
        backlight = {
          format-icons = ["" "" "" "" "" "" "" "" ""];
          format = "<span color='#b4befe'>{icon}</span> {percent}%";
          on-scroll-up = "brightnessctl set +1%";
          on-scroll-down = "brightnessctl set -1%";
        };

        # Pulseaudio
        pulseaudio = {
          format = "<span color='#b4befe'>{icon}</span> {volume}%";
          format-bluetooth = "󰂰";
          tooltip-format = "Volume: {volume}%";
          "format-muted" = "󰝟";
          format-icons = {
            default = ["󰖀" "󰕾" ""];
            headphone = "";
            headset = "";
            hands-free = "";
          };
          on-click = "pavucontrol";
        };

        # Battery
        battery = {
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format = "<span color='#737373'>{icon}</span> {capacity}%";
          format-charging = "<span color='#b2f252'>󰂄</span> {capacity}%";
          format-plugged = "<span color='#b2f252'>󰚥</span> MAX";
          interval = 5;
          tooltip-format = "{timeTo}, {capacity}%\n {power} W";
          states = {
            warning = 30;
            critical = 15;
          };
        };
      }
    ];
    style = ''
      @define-color bg #0d0d0d;
      @define-color darkgrey #131822;
      @define-color lightgrey #343a40;
      @define-color red #e30b44;
      @define-color white #f2efeb;
      @define-color flake #d2fff3;
      @define-color icyblue #aad1ee;
      @define-color flakeicy #e5f0fa;
      @define-color avocado #c1d98f;
      @define-color lightyellow #f6eac4;
      @define-color tray #181825;

      * {
        border: none;
        border-radius: 10px;
        min-height: 0;
        font-family: Noto Sans Mono, Noto Sans Mono CJK SC, FiraCode Nerd Font;
        font-size: 12px;
        background: none;
      }

      window#waybar {
        background: transparent;
      }

      tooltip {
      border-radius: 8px;
      padding: 15px;
      background-color: @darkgrey;
      }

      tooltip label {
      padding: 5px;
      background-color: @darkgrey;
      }

      #workspaces {
        margin: 6px 3px;
        background: @bg;
      }

      #workspaces button {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        box-shadow: inset 0 -3px transparent; /* Use box-shadow instead of border so the text isn't offset */
        padding: 6px 10px;
        border-radius: 6px;
        background-color: @bg;
        color: @lightgrey;
        font-size: 10px;
      }

      #workspaces button.active {
        color: @lightyellow;
      }

      #workspaces button:hover {
       box-shadow: inherit;
       text-shadow: inherit;
       color: @lightyellow;
       background-color: @lightgrey;
      }

      #temperature,
      #cpu,
      #memory,
      #custom-power,
      #custom-nixlogo,
      #custom-weather,
      #custom-pacman,
      #backlight,
      #pulseaudio,
      #network,
      #battery,
      #backlight,
      #bluetooth,
      #clock,
      #tray {
        border-radius: 8px;
        margin: 6px 2px;
        padding: 6px 12px;
        background-color: @bg;
        color: @tray;
      }

      #temperature,
      #cpu,
      #memory,
      #backlight,
      #pulseaudio,
      #network,
      #battery,
      #backlight,
      #bluetooth{
        color: @lightyellow;
        background-color: @bg;
      }

      #clock{
        font-family: JetBrainsMono Nerd Font;
        background-color: @flake;
      }

      #custom-weather,
      #custom-power {
        background-color: @bg;
        color: @lightyellow;
      }

      #custom-nixlogo {
        font-size: 14px;
        color: @icyblue;
      }
    '';
  };
}
