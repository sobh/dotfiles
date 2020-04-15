#!/bin/sh
pidof dunst && killall dunst
dunst &

notify-send 'Title' "The quick brown fox jumps over the lazy dog."
notify-send "Message one"
notify-send -u low "Message Two"
notify-send -u critical "Message Three"

