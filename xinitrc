#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#---- Displays' Settings -------------------------------------------------------
#xrandr --output VGA1 --mode 1920x1080 --left-of LVDS1
#xrandr --output LVDS1 --off
#xrandr --output VGA1 --mode 1920x1080
#xrandr --output VGA1 --mode 1280x1024 --above LVDS1

# Allow Switching Keyboard map usint [alt+caps] --------------------------------
setxkbmap -layout "us, ara" -variant ",qwerty_digits" -option "grp:alt_caps_toggle"

# Parse .Xresources File -------------------------------------------------------
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Set Window Manger Name to be recogonized by Java -----------------------------
#wmname LG3D

# Start The Window Manager -----------------------------------------------------
exec /usr/bin/dwm
#exec /usr/bin/openbox-session
#/usr/bin/i3
