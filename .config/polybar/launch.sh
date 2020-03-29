#!/usr/bin/env bash
 
# Terminate already running bar instances
killall -q polybar
 
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
 
# Launch bar1 and bar2
bar1=main
bar2=extra
echo "---" | tee -a /tmp/$bar1.log /tmp/$bar2.log
 
MONITOR="eDP-1" polybar --reload $bar1 -c ~/.config/polybar/config >>/tmp/$bar1.log 2>&1 &
 
externo=$(xrandr --query | grep "HDMI-1")
if [[ ! $external = *disconnected* ]]; then
  MONITOR="HDMI-1" polybar --reload $bar2 -c ~/.config/polybar/config >>/tmp/$bar2.log 2>&1 &
fi
 
echo "Bars launched..."
