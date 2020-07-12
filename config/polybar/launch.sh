#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep  polybar >/dev/null; do sleep 1; done

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -r workspaces &     # top left
    MONITOR=$m polybar -r window_title &   # top center
    MONITOR=$m polybar -r date &           # top right
    #MONITOR=$m polybar -r padding_top &
    MONITOR=$m polybar -r status &         # bottom right
    MONITOR=$m polybar -r fs &             # bottom left

    MONITOR=$m polybar -r tray &           # bottom left
    #MONITOR=$m polybar -r padding_bottom &
  done
else
  polybar -r workspaces &       # top left
  polybar -r window_title &     # top center
  polybar -r date &             # top right
  #polybar -r padding_top &
  polybar -r status &           # bottom right
  polybar -r fs &               # bottom left
  #polybar -r padding_bottom &

  polybar -r tray &             # bottom left
fi

echo "Bars launched..."
