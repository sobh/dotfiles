#!/bin/bash
#
# $HOME/.xinitrc
#

# Set Defautl window manager (values: i3, dwm)
: ${WM:=i3}; export WM
# Set Defautl UI icone style (values: emoji, nerd)
: ${UI_ICON:=emoji}; export UI_ICON

#---- Displays' Settings -------------------------------------------------------
[[ -f $XDG_CONFIG_HOME/xrandr/$HOSTNAME ]] && source $XDG_CONFIG_HOME/xrandr/$HOSTNAME

# Allow Switching Keyboard map usint [alt+caps] --------------------------------
setxkbmap -layout "us, ara" -variant ",qwerty_digits" -option "grp:alt_caps_toggle"

# Disable Beeps
xset -b

#---- Xresources ---------------------------------------------------------------
# We don't merge :p
[[ -f $HOME/.Xresources ]] && xrdb $HOME/.Xresources

#---- HiDPI --------------------------------------------------------------------
#-------- GTK-3.0 ----------------------
export GDK_SCALE=2		# Scale UI Element
export GDK_DPI_SCALE=0.5	# Scale Back Text
#-------- QT5 --------------------------
# Make QT5 Applications honor screen DPI
export QT_AUTO_SCREEN_SCALE_FACTOR=1

#---- Startup Applications -----------------------------------------------------

if [ $WM = i3 ] ; then
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
			ssh-agent $HOME/bin/dwm
		done
		;;
	*)
		echo "Unkown window manager $WM" ;;
esac
	#exec $HOME/bin/dwm
