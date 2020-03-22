#!/usr/bin/sh
xrandr \
	--output LVDS-1 --mode 1920x1080 \
	--output DP-1 --mode  2560x1440 --left-of LVDS-1

# xrandr --fb 8064x3456 \
# 	--output LVDS-1 --mode 1920x1080 --pos 6144x0 \
# 	--output DP-1 --mode 3840x2160 --scale 1.6x1.6 --pos 0x0 --panning 6144x3456+0+0

# 1.5x1.5
#xrandr --fb 2880x3240 \
#	--output LVDS-1 --mode 1920x1080 --pos 0x1620 \
#	--output VGA-1 --mode 1920x1080 --scale 1.5x1.5 --pos 0x0 --panning 2880x1620+0+0

# 2x2
#xrandr --fb 7680x5400 \
#	--output LVDS-1 --mode 1920x1080 --pos 0x4320 \
#	--output DP-1 --mode 3840x2160 --scale 2x2 --pos 0x0 --panning 7680x4320+0+0

# Panning = W*scale x H*scale + pos x + pos y
