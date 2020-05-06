#!/bin/sh
#
# $HOME/.xinitrc
#

#---- Source X11/Wayland common configurations ---------------------------------
. $XDG_CONFIG_HOME/xw_common

#---- Set the Environment Parameters -------------------------------------------
# Set Session Type
export XDG_SESSION_TYPE='x11'
# Set Defautl window manager (values: i3, dwm)
: ${WM:=i3}; export WM

#---- Displays' Settings -------------------------------------------------------
[ -f $XDG_CONFIG_HOME/xrandr/$HOST ] && . $XDG_CONFIG_HOME/xrandr/$HOST

# Set keyboard
exec setkeyboard &
# Disable Beeps
xset -b
# Hide mouse cursor when idle
exec unclutter &

#---- Xresources ---------------------------------------------------------------
loadxresources

#---- Startup Applications -----------------------------------------------------

if [ "$WM" = "i3" ] ; then
	exec dropbox &
	exec firejail dropbox-atc.sh &
fi

# Import DISPLAY from environemtn for Xapplication services (e.g. dunst)
systemctl --user import-environment DISPLAY XAUTHORITY

#---- Window Manager -----------------------------------------------------------
# Set Window Manger Name to be recogonized by Java
wmname gnome

case $WM in
	i3)
		exec /usr/bin/i3 ;;
	dwm)
		while : ; do
			ssh-agent /usr/local/bin/dwm
		done
		;;
	*)
		echo "Unkown window manager $WM" ;;
esac

