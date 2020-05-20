#!/bin/bash

# NOTE: This is a very simplistic approach because I alerady know the settings I want to apply

setup_display()
{
	xrandr --output "$primary_monitor_name" --primary --mode 1920x1080 --rotate normal --output "$external_monitor_name" --mode 1920x1080 --rotate normal --right-of "$primary_monitor_name"
}

one_monitor_settings()
{
	bspc monitor "$primary_monitor_name" -d   1 2 3 4 5 6 7 8 9 10
}

start_apps()
{
    "$HOME"/.config/polybar/launch.sh
}

two_monitor_settings()
{
    setup_display
	bspc monitor "$primary_monitor_name" -d   1 2 3 4 5
    bspc monitor "$external_monitor_name" -d  6 7 8 9 10
    bspc config -m "$external_monitor_name" top_padding       20
    bspc config -m "$external_monitor_name" bottom_padding    30 # +10 because of polybar
    bspc config -m "$external_monitor_name" left_padding      20
    bspc config -m "$external_monitor_name" right_padding     20
    start_apps
}

primary_monitor_name="eDP-1"
external_monitor_name=$(xrandr -q | grep -w connected | grep -v $primary_monitor_name | cut -f1 -d" ")

if [[ $(monitor_count) -eq 2 ]]; then
    two_monitor_settings
else
    one_monitor_settings
fi
