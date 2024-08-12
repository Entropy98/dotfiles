#!/bin/bash

killall -q polybar

# Get monitors
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload mybar --config=$HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown
done

echo "Polybar launched..."
