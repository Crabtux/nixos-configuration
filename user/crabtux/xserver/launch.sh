#!/usr/bin/env bash

# Add this script to your wm startup file.

export MONITOR="eDP-1"

# Terminate already running bar instances
killall -q .polybar-wrapper

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar -q top &
polybar -q bottom &
