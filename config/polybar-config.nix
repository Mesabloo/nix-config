{ pkgs }:

{
  ### Colors

  "colors" = {
    # Grays
    nord0 = "\${xrdb:background:#2E3440}";
    nord1 = "\${xrdb:color0:#3B4252}";
    nord2 = "#434C5E";
    nord3 = "\${xrdb:color8:#4C566A}";
    # Whites
    nord4 = "\${xrdb:foreground:#D8DEE9}";
    nord5 = "\${xrdb:color7:#E5E9F0}";
    nord6 = "\${xrdb:color15:#ECEFF4}";
    # Greens/blues
    nord7 = "\${xrdb:color14:#8FBCBB}";
    nord8 = "\${xrdb:color6:#88C0D0}";
    nord9 = "\${xrdb:color12:#81A1C1}";
    nord10 = "#5E81AC";
    # Red
    nord11 = "\${xrdb:color9:#BF616A}";
    # Orange
    nord12 = "#D08770";
    # Yellow
    nord13 = "\${xrdb:color11:#EBCB8B}";
    # Green
    nord14 = "\${xrdb:color10:#A3BEBC}";
    # Magenta
    nord15 = "\${xrdb:color13:#B48EAD}";
  };

  "values" = {
    border-size = 1;
  };

  ### Common stuff

  "bar/common" = {
    monitor = "\${env:MONITOR:}";

    width = "100%";
    height = 20;

    override-redirect = false;

    background = "\${colors.nord0}";
    foreground = "\${colors.nord4}";
    border-color = "\${colors.nord2}";
    border-size = "\${values.border-size}";

    radius = 0;

    font-0 = "Iosevka Nerd Font:style=Medium:size=9.25;2";
    font-1 = "Font Awesome 5 Free Solid:size=8";
    font-2 = "Font Awesome 5 Brands:size=8";
    font-3 = "MPlus Nerd Font:style=Medium:size=9.25;2";
    font-4 = "MPlus Nerd Font:style=Medium:size=10.5;3";
  };

  "module/barsep" = {
    type = "custom/text";
    content = "│";
    content-foreground = "\${colors.nord2}";
  };

  "module/emptysep" = {
    type = "custom/text";
    content = " ";
  };

  "settings" = {
    screenchange-reload = true;
  };

  ### Modules 

  "module/ewmh" = rec {
    type = "internal/xworkspaces";

    pin-workspaces = false;

    enable-click = false;
    enable-scroll = false;

    format = " <label-state>";
    format-background = "\${colors.nord1}";
    format-foreground = "\${colors.nord6}";
    format-padding = 1;
    # format-font = 3;

    label-active = "%icon% ";
    label-active-foreground = "\${colors.nord7}";
    label-active-padding = 1;

    label-occupied = label-active;
    label-occupied-padding = label-active-padding;

    label-urgent = label-active;
    label-urgent-foreground = "\${colors.nord11}";
    label-urgent-padding = label-active-padding;

    label-empty = label-active;
    label-empty-foreground = "\${colors.nord3}";
    label-empty-padding = label-active-padding;

    icon-0 = "chat;󰭹";
    icon-1 = "dev;";
    icon-2 = "www;";
    icon-3 = "music;󰝚";
    icon-4 = "settings;";
    icon-5 = "games;󰮂";
    icon-default = "";
  };

  "module/windowtitle" = {
    type = "internal/xwindow";

    format = "<label>";
    format-foreground = "\${colors.nord5}";
    format-padding = 1;

    label = "  %title%";
    label-maxlen = 150;
    label-empty = "";
  };

  "module/date" = {
    type = "internal/date";
    interval = 20;

    date = "%A, %d %B %Y";
    time = "%H:%M";

    format = "<label>";
    format-foreground = "\${colors.nord5}";
    format-padding = 1;

    label = "  %date% - %time% ";
  };

  "module/poweroff-button" = {
    type = "custom/script";

    exec = "echo '⏼ '";

    format = "<label>";
    format-foreground = "\${colors.nord11}";
    format-background = "\${colors.nord1}";
    format-padding = 1;

    label = "%output%";

    double-click-left = "${pkgs.libnotify}/bin/notify-send 'XMonad' 'Shutting down in 5s...' --app-name 'xmonad' -u critical; sleep 5; shutdown -P now";
  };

  "module/restart-button" = {
    type = "custom/script";

    exec = "echo ''";

    format = "<label>";
    format-foreground = "\${colors.nord12}";
    format-background = "\${colors.nord1}";
    format-padding = 1;

    label = "%output%";

    double-click-left = "${pkgs.libnotify}/bin/notify-send 'XMonad' 'Restarting in 5s...' --app-name 'xmonad' -u critical; sleep 5; shutdown -r now";
  };

  "module/logout-button" = {
    type = "custom/script";

    exec = "echo ''";

    format = "<label>";
    format-foreground = "\${colors.nord14}";
    format-background = "\${colors.nord1}";
    format-padding = 1;

    label = "%output%";

    double-click-left = "${pkgs.libnotify}/bin/notify-send 'XMonad' 'Logging out in 5s...' --app-name 'xmonad' -u critical; sleep 5; ${pkgs.killall}/bin/killall -r 'xmonad*' -s TERM";
  };

  "module/sleep-button" = {
    type = "custom/script";

    exec = "echo '󰒲'";

    format = "<label>";
    format-foreground = "\${colors.nord13}";
    format-background = "\${colors.nord1}";
    format-padding = 1;

    label = "%output%";

    double-click-left = "${pkgs.systemd}/bin/systemctl suspend";
  };

  "module/ewmh-rightanglesep" = {
    type = "custom/text";

    content = " ";
    content-background = "\${colors.nord0}";
    content-foreground = "\${colors.nord1}";
    content-font = 5;
  };

  "module/powermenu-leftanglesep" = {
    type = "custom/text";

    content = " ";
    content-background = "\${colors.nord0}";
    content-foreground = "\${colors.nord1}";
    content-font = 5;
  };

  "module/filesystem" = rec {
    type = "internal/fs";

    mount-0 = "/";
    mount-1 = "/home";

    interval = 10;

    fixed-values = true;

    spacing = 0;
    spacing-background = "\${colors.nord5}";

    warn-percentage = 90;

    format-mounted = "<bar-used><label-mounted>";
    format-mounted-background = "\${colors.nord1}";
    format-unmounted = "<label-unmounted>";
    format-unmounted-background = format-mounted-background;

    label-mounted = " %percentage_used:3:3%% %mountpoint% (%free%/%total%) ";
    label-mounted-foreground = "\${colors.nord4}";
    label-mounted-background = "\${colors.nord1}";

    label-mounted-warn = label-mounted;
    label-mounted-warn-foreground = "\${colors.nord11}";

    label-unmounted = "%mountpoint% not mounted";
    label-unmounted-foreground = "\${colors.nord11}";
    label-unmounted-background = label-mounted-background;

    bar-used-indicator = "";
    bar-used-width = 10;
    bar-used-foreground-0 = "\${colors.nord14}";
    bar-used-foreground-1 = "\${colors.nord13}";
    bar-used-foreground-2 = "\${colors.nord12}";
    bar-used-foreground-3 = "\${colors.nord11}";
    bar-used-background = "\${colors.nord1}";
    bar-used-fill = "▐";
    bar-used-empty = "▐";
    bar-used-empty-foreground = "\${colors.nord3}";
  };

  "module/fs-sep" = {
    type = "custom/text";
    content = " ";
    content-foreground = "\${colors.nord1}";
    content-background = "\${colors.nord0}";
    content-font = 5;
  };

  "module/volume" = rec {
    type = "internal/pulseaudio";

    use-ui-max = false;

    interval = 4;

    format-volume = "<ramp-volume> <label-volume>";
    format-muted = "<label-muted>";
    format-volume-padding = 1;
    format-muted-padding = format-volume-padding;

    label-muted = "   0%";
    label-muted-foreground = "\${colors.nord2}";

    label-volume = "%percentage:3:3%%";
    label-volume-foreground = "\${colors.nord5}";

    ramp-volume-0 = "";
    ramp-volume-0-foreground = "\${colors.nord14}";
    ramp-volume-1 = "";
    ramp-volume-1-foreground = "\${colors.nord13}";
    ramp-volume-2 = "";
    ramp-volume-2-foreground = "\${colors.nord12}";

    label-volume-0-foreground = "\${colors.nord12}";
  };

  "module/backlight" = rec {
    type = "internal/backlight";
    card = "intel_backlight";

    format = "<ramp> <label>";
    format-padding = 1;

    label = "%percentage:3:3%%";

    ramp-0 = "󰃞";
    ramp-0-foreground = "\${colors.nord13}";
    ramp-1 = "󰃟";
    ramp-1-foreground = ramp-0-foreground;
    ramp-2 = "󰃠";
    ramp-2-foreground = ramp-0-foreground;

    enable_scroll = false;
  };

  "module/battery" = rec {
    type = "internal/battery";

    full-at = 100;
    low-at = 15;
    poll-interval = 5;

    format-discharging = "<ramp-capacity> <label-discharging>";
    format-full = "<ramp-capacity> <label-full>";
    format-charging = "<label-charging>";
    format-charging-padding = 1;
    format-discharging-padding = format-charging-padding;
    format-full-padding = format-charging-padding;

    label-charging = "󰂄 %percentage:3:3%%";
    label-charging-foreground = "\${colors.nord15}";
    label-discharging = "%percentage:3:3%%";
    label-full = "full";
    label-warn = label-discharging;
    label-warn-foreground = "\${colors.nord11}";

    ramp-capacity-0 = "󰂎";
    ramp-capacity-0-foreground = "\${colors.nord11}";
    ramp-capacity-1 = "󰁺";
    ramp-capacity-1-foreground = ramp-capacity-0-foreground;
    ramp-capacity-2 = "󰁻";
    ramp-capacity-2-foreground = "\${colors.nord12}";
    ramp-capacity-3 = "󰁼";
    ramp-capacity-3-foreground = ramp-capacity-2-foreground;
    ramp-capacity-4 = "󰁽";
    ramp-capacity-4-foreground = ramp-capacity-2-foreground;
    ramp-capacity-5 = "󰁾";
    ramp-capacity-5-foreground = "\${colors.nord13}";
    ramp-capacity-6 = "󰁿";
    ramp-capacity-6-foreground = ramp-capacity-5-foreground;
    ramp-capacity-7 = "󰂀";
    ramp-capacity-7-foreground = "\${colors.nord14}";
    ramp-capacity-8 = "󰂁";
    ramp-capacity-8-foreground = ramp-capacity-7-foreground;
    ramp-capacity-9 = "󰂂";
    ramp-capacity-9-foreground = ramp-capacity-7-foreground;
  };

  "module/eth" = rec {
    type = "internal/network";

    interface = "\${env:ETHER_IF:}";
    interface-type = "wired";

    interval = 5;

    format-connected = "<label-connected>";
    format-connected-padding = 1;
    format-disconnected = "<label-disconnected>";
    format-disconnected-padding = format-connected-padding;
    format-packetloss = "<label-packetloss>";
    format-packetloss-padding = format-connected-padding;

    label-connected = "󰈀";
    label-connected-foreground = "\${colors.nord14}";
    label-disconnected = label-connected;
    label-disconnected-foreground = "\${colors.nord3}";
    label-packetloss = label-connected;
    label-packetloss-foreground = "\${colors.nord11}";
  };

  "module/wlan" = rec {
    type = "internal/network";

    interface = "\${env:WIFI_IF:}";
    interface-type = "wireless";

    interval = 5;

    format-connected = "<label-connected>";
    format-connected-padding = 1;
    format-disconnected = "<label-disconnected>";
    format-disconnected-padding = format-connected-padding;
    format-packetloss = "<label-packetloss>";
    format-packetloss-padding = format-connected-padding;

    label-connected = "󱚽";
    label-connected-foreground = "\${colors.nord14}";
    label-disconnected = "󰖪";
    label-disconnected-foreground = "\${colors.nord3}";
    label-packetloss = "󱚵";
    label-packetloss-foreground = "\${colors.nord11}";
  };

  "module/bluetooth" = {
    type = "custom/script";

    exec = "${pkgs.polybar-scripts.bluetooth}/bin/bluetooth.sh '%{F#4C566A}󰂯%{F-}' '%{F#E5E9F0}󰂯%{F-}' '%{F#A3BE8C}󰂯%{F-}'";

    interval = 5;

    format = "<label>";
    format-padding = 1;

    label = "%output%";

    click-left = "${pkgs.polybar-scripts.bluetooth}/bin/toggle_bluetooth.sh";
  };

  "module/keyboard" = rec {
    type = "internal/xkeyboard";

    format = "<label-layout><label-indicator>";
    format-padding = 1;

    label-layout = "󰌌  %layout%";
    label-layout-foreground = "\${colors.nord5}";

    indicator-icon-default = "";
    indicator-icon-0 = "num lock;;";
    indicator-icon-1 = "caps lock;;";
    indicator-icon-2 = "scroll lock;;";

    label-indicator-on = " %icon%";
    label-indicator-on-foreground = "\${colors.nord5}";
    label-indicator-off = label-indicator-on;
    label-indicator-off-foreground = "\${colors.nord3}";
  };

  "module/swap" = rec {
    type = "internal/memory";

    interval = 1;

    format = "󰗮 <bar-swap-used> <label>";
    format-padding = 1;

    label = "%percentage_swap_used:3:3%%";
    label-foreground = "\${colors.nord5}";
    label-warn = label;
    label-warn-foreground = "\${colors.nord11}";

    bar-swap-used-indicator = "";
    bar-swap-used-width = 10;
    bar-swap-used-foreground-0 = "\${colors.nord14}";
    bar-swap-used-foreground-1 = "\${colors.nord13}";
    bar-swap-used-foreground-2 = "\${colors.nord12}";
    bar-swap-used-foreground-3 = "\${colors.nord11}";
    bar-swap-used-fill = "▐";
    bar-swap-used-empty = "▐";
    bar-swap-used-empty-foreground = "\${colors.nord3}";
  };

  "module/ram" = rec {
    type = "internal/memory";

    interval = "0.5";

    format = "󰍛 <bar-used> <label>";
    format-padding = 1;

    label = "%percentage_used:3:3%%";
    label-foreground = "\${colors.nord5}";
    label-warn = label;
    label-warn-foreground = "\${colors.nord11}";

    bar-used-indicator = "";
    bar-used-width = 10;
    bar-used-foreground-0 = "\${colors.nord14}";
    bar-used-foreground-1 = "\${colors.nord13}";
    bar-used-foreground-2 = "\${colors.nord12}";
    bar-used-foreground-3 = "\${colors.nord11}";
    bar-used-fill = "▐";
    bar-used-empty = "▐";
    bar-used-empty-foreground = "\${colors.nord3}";
  };

  "module/cpu" = rec {
    type = "internal/cpu";

    interval = 1;

    format = "  <ramp-coreload> <label>";
    format-padding = 1;

    label = "%percentage:3:3%%";
    label-foreground = "\${colors.nord5}";

    ramp-coreload-spacing = 0;
    ramp-coreload-0 = "▁";
    ramp-coreload-0-foreground = "\${colors.nord14}";
    ramp-coreload-1 = "▂";
    ramp-coreload-1-foreground = ramp-coreload-0-foreground;
    ramp-coreload-2 = "▃";
    ramp-coreload-2-foreground = "\${colors.nord13}";
    ramp-coreload-3 = "▄";
    ramp-coreload-3-foreground = ramp-coreload-2-foreground;
    ramp-coreload-4 = "▅";
    ramp-coreload-4-foreground = "\${colors.nord12}";
    ramp-coreload-5 = "▆";
    ramp-coreload-5-foreground = ramp-coreload-4-foreground;
    ramp-coreload-6 = "▇";
    ramp-coreload-6-foreground = "\${colors.nord11}";
    ramp-coreload-7 = "█";
    ramp-coreload-7-foreground = ramp-coreload-6-foreground;
  };

  "module/temperature" = rec {
    type = "internal/temperature";

    interval = 5;

    base-temperature = 20;
    warn-temperature = 70;

    units = true;

    format = "<ramp> <label>";
    format-padding = 1;
    format-warn = "<ramp> <label-warn>";
    format-warn-padding = format-padding;

    label = "%temperature-c:5:5%";
    label-foreground = "\${colors.nord5}";
    label-warn = label;
    label-warn-foreground = "\${colors.nord11}";

    ramp-0 = "";
    ramp-0-foreground = "\${colors.nord14}";
    ramp-1 = "";
    ramp-1-foreground = ramp-0-foreground;
    ramp-2 = "";
    ramp-2-foreground = "\${colors.nord13}";
    ramp-3 = "";
    ramp-3-foreground = "\${colors.nord12}";
    ramp-4 = "";
    ramp-4-foreground = "\${colors.nord11}";
  };

  "module/player-mpris" =
    let
      player-mpris = "${pkgs.polybar-scripts.player-mpris-tail}/bin/player-mpris-tail";
    in
    {
      type = "custom/script";
      exec = "${player-mpris} -f '%{T5}%{A1:${player-mpris} previous:}%{F#8FBCBB}󰙣%{F-}%{A} %{A1:${player-mpris} play-pause:}%{F#88C0D0}{icon-reversed}%{F-}%{A} %{A1:${player-mpris} next:}%{F#8FBCBB}󰙡%{F-}%{A} %{T-} {:t100:{artist} - {title}:}' --icon-playing '󱉺' --icon-paused '󰏥' --icon-stopped 'No music playing …' --icon-none 'No music playing …'";

      tail = true;

      format = "<label>";
      format-padding = 1;
      label = "%output%";
    };

  "module/dnd" =
    let
      dunstctl = "${pkgs.dunst}/bin/dunstctl";
    in
    {
      type = "custom/script";
      exec = "if [ $(${dunstctl} is-paused) = 'true' ]; then echo '%{F#BF616A}󰂛%{F-}'; else echo '%{F#A3BE8C}󰂚%{F-}'; fi";
      interval = 5;

      format = "<label>";
      format-padding = 1;
      label = "%output%";

      click-left = "${dunstctl} set-paused toggle";
    };

  ### Bars

  "bar/wminfo" = {
    "inherit" = "bar/common";

    bottom = false;

    fixed-center = true;

    modules-left = "ewmh ewmh-rightanglesep";
    modules-center = "windowtitle";
    modules-right = "date powermenu-leftanglesep logout-button sleep-button restart-button poweroff-button";
  };

  "bar/systeminfo" = {
    "inherit" = "bar/common";

    fixed-center = true;

    modules-left = "filesystem fs-sep";
    modules-center = "player-mpris";
    modules-right = "barsep temperature emptysep cpu barsep ram barsep keyboard barsep bluetooth eth wlan emptysep barsep backlight battery volume barsep dnd emptysep";
    #                                                           ^ emptysep swap
  };

  "bar/systeminfo-top" = {
    "inherit" = "bar/systeminfo";
  };

  "bar/systeminfo-bottom" = {
    "inherit" = "bar/systeminfo";
    bottom = true;
  };
}
