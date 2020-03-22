#!/usr/bin/sh
xrandr  --fb 4608x1512 \
	--output LVDS-1 --mode 1920x1080 --pos 2688x432 \
	--output VGA-1 --primary --mode 1920x1080 --scale 1.4x1.4 --pos 0x0 --panning 2688x1512+0+0 \

# 1.5x1.5
#xrandr --fb 4800x1620 \
#	--output LVDS-1 --mode 1920x1080 --pos 2880x0 \
#	--output VGA-1 --mode 1920x1080 --scale 1.5x1.5 --pos 0x0 --panning 2880x1620+0+0

# 2x2
#xrandr --fb 3840x2160 \
#	--output LVDS-1 --mode 1920x1080 --pos 0x2161 \
#	--output VGA-1 --mode 1920x1080 --scale 2x2 --pos 0x0 --panning 3840x2160+0+0

# Panning = W*scale x H*scale + pos x + pos y
