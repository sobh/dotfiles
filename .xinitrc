#!/bin/sh
#
# $HOME/.xinitrc
#

#---- Set the Environment Parameters -------------------------------------------
# Set Defautl window manager (values: i3, dwm)
: ${WM:=i3}; export WM
# Set Defautl UI icone style (values: emoji, nerd)
: ${UI_ICON:=emoji}; export UI_ICON
# DPI Settings based on host
case $HOST in
	optiplex) DPI=200;;
	satellite |t420) DPI=150;;
	*)  DPI=92;;
esac
export DPI

#---- Displays' Settings -------------------------------------------------------
[ -f $XDG_CONFIG_HOME/xrandr/$HOST ] && . $XDG_CONFIG_HOME/xrandr/$HOST

# Set keyboard
exec setkeyboard &
# Disable Beeps
xset -b

#---- Xresources ---------------------------------------------------------------
loadxresources

#---- HiDPI --------------------------------------------------------------------
#-------- GTK-3.0 ----------------------
export GDK_SCALE=2		# Scale UI Element
export GDK_DPI_SCALE=0.5	# Scale Back Text
#-------- QT5 --------------------------
# Make QT5 Applications honor screen DPI
export QT_AUTO_SCREEN_SCALE_FACTOR=1

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
	#exec $HOME/bin/dwm
