#!/usr/bin/env bash

# Terminate already running bar instances
killall -r 'polybar*' -w

if type 'xrandr' &> /dev/null; then
  SCREEN_COUNT=$(xrandr --listactivemonitors | grep 'Monitors:' | awk '{print $2}')

  case $SCREEN_COUNT in
    1)
      polybar -c '##POLYBAR-WMINFO##' wminfo &
      polybar -c '##POLYBAR-SYSINFO##' systeminfo-bottom &
    ;;
    *)
      # Let's assume that the screen numbers represent their order from left to right
      SCREENS_INFO=($(xrandr --query | grep ' connected' | cut -d' ' -f1 | sort))
      SCREEN_0=${SCREENS_INFO[0]}
      SCREEN_N=${SCREENS_INFO[-1]}

      MONITOR=$SCREEN_0 polybar -c '##POLYBAR-WMINFO##' wminfo &
      MONITOR=$SCREEN_N polybar -c '##POLYBAR-SYSINFO##' systeminfo-top &
    ;;
  esac
else
  # Assuming only one screen...
  polybar -c '##POLYBAR-WMINFO##' wminfo &
  polybar -c '##POLYBAR-SYSINFO##' systeminfo-bottom &
fi
