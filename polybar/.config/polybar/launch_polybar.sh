#!/usr/bin/bash

killall -q polybar

while pgrep -u "$USER" -x polybar > /dev/null;do sleep 1; done;

exec polybar --reload --config="$HOME/.config/polybar/config.ini" topbar
