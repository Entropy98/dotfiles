#!/bin/bash

killall -q polybar
polybar mybar --config=$HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
