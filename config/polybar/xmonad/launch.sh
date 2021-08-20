#!/usr/bin/env bash

# Terminate already running bar instances
echo "polybar> killing all running instances:"
##KILL_POLYBARS##

# killall -r 'polybar*' -w || true

WIFI=$(ip link | awk -F'( |:)' '$3 ~ /wl.*/ {print $3}')
ETHE=$(ip link | awk -F'( |:)' '$3 ~ /enp.*/ {print $3}')

if type 'xrandr' &> /dev/null; then
  SCREENS=($(xrandr --query | grep ' connected' | cut -d' ' -f1 | sort))
  SCREEN_COUNT=${#SCREENS[@]}

  echo "polybar> $SCREEN_COUNT monitor(s) found!"

  case $SCREEN_COUNT in
    1)
      polybar -c '##POLYBAR-WMINFO##' wminfo &
      WIFI_IF="$WIFI" ETHER_IF="$ETHE" polybar -c '##POLYBAR-SYSINFO##' systeminfo-bottom &
    ;;
    *)
      # Let's assume that the screen numbers represent their order from left to right
      SCREEN_0=${SCREENS[0]}
      SCREEN_N=${SCREENS[-1]}

      MONITOR=$SCREEN_0 polybar -c '##POLYBAR-WMINFO##' wminfo &
      WIFI_IF="$WIFI" ETHER_IF="$ETHE" MONITOR=$SCREEN_N polybar -c '##POLYBAR-SYSINFO##' systeminfo-top &
    ;;
  esac
else
  # Assuming only one screen...
  echo "polybar> couldn't get 'xrandr', falling back to one monitor mode..."

  polybar -c '##POLYBAR-WMINFO##' wminfo &
  WIFI_IF="$WIFI" ETHER_IF="$ETHE" polybar -c '##POLYBAR-SYSINFO##' systeminfo-bottom &
fi
