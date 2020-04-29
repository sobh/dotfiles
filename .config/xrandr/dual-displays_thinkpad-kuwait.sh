#!/bin/sh
xrandr	\
	--output LVDS1 --mode 1920x1080 --pos 2560x360 --rotate normal \
	--output DP1 --primary --mode 2560x1440 --pos 0x0 --rotate normal
