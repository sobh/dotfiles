#!/bin/sh
keyboard_flag()
{
	while read ; do
		pkill -SIGRTMIN+1 i3blocks
	done
}
swaymsg --monitor --type subscribe '["input"]' | keyboard_flag
