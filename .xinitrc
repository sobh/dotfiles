#!/bin/sh
#
# $HOME/.xinitrc
#

#---- Set the Environment Parameters -------------------------------------------
# Set Session Type (x11, or wayland)
export XDG_SESSION_TYPE='x11'
# Set Default window manager (values: i3, dwm)
: ${WM:=i3}; export WM

# Set Defautl UI icone style (values: emoji, nerd)
: ${UI_ICON:=emoji}; export UI_ICON

#---- Host Configuration -------------------------------------------------------
# DPI Settings based on host
case $HOST in
	optiplex)
		DPI=200
		UI_FONT_SIZE=12
		;;
	satellite |t420 |ed)
		DPI=144		    # Scale of 1.5
		UI_FONT_SIZE=10
		;;
	*)
		DPI=92
		UI_FONT_SIZE=12
		;;
esac

export DPI
export UI_FONT_SIZE
export UI_FONT_FAMILY='system-ui'
export UI_FONT_WEIGHT='Light'
export UI_FONT="$UI_FONT_FAMILY $UI_FONT_WEIGHT $UI_FONT_SIZE"

#---- HiDPI --------------------------------------------------------------------
if [ $DPI -ge 180 ] ; then
	#-------- GTK-3.0 ----------------------
	export GDK_SCALE=2		# Scale UI Element
	export GDK_DPI_SCALE=0.5	# Scale Back Text
	#-------- QT5 --------------------------
	# Make QT5 Applications honor screen DPI
	export QT_AUTO_SCREEN_SCALE_FACTOR=1
fi
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
	exec dropbox-atc.sh &
fi

# Import DISPLAY from environemtn for Xapplication services (e.g. dunst)
systemctl --user import-environment DISPLAY XAUTHORITY

#---- Window Manager -----------------------------------------------------------
# Set Window Manger Name to be recogonized by Java
wmname gnome

case $WM in
	i3) exec /usr/bin/i3 ;;
	dwm) exec /usr/local/bin/dwm ;;
	*) echo "Unkown window manager $WM" ;;
esac

