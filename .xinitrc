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
#xrandr --output VGA1 --mode 1920x1080 --above LVDS1

[[ -f ~/.config/xrandr/config ]] && source ~/.config/xrandr/config


# Allow Switching Keyboard map usint [alt+caps] --------------------------------
setxkbmap -layout "us, ara" -variant ",qwerty_digits" -option "grp:alt_caps_toggle"

# Disable Beeps
xset -b
# Parse .Xresources File -------------------------------------------------------
XRS_HOME=$XDG_CONFIG_HOME/xresources
XRS_HOST=$XRS_HOME/hosts/$HOSTNAME.Xresources
[[ -f $XRS_HOME/Xresources ]] && xrdb -merge -I$XRS_HOME $XRS_HOME/Xresources
#[[ -f $XRS_HOST ]] && xrdb -merge -I$XRS_HOME $XRS_HOST

#---- Applets ------------------------------------------------------------------
exec volumeicon &
exec nm-applet &
# Set Window Manger Name to be recogonized by Java -----------------------------
wmname gnome

exec dropbox &
exec firejail dropbox-atc.sh &

# Start The Window Manager -----------------------------------------------------
#exec /usr/bin/dwm
#exec /usr/bin/openbox-session
exec /usr/bin/i3