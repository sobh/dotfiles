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
HOST_CONFIG_DIR=$XDG_CONFIG_HOME/host/$HOST
# Load defualt host configuration
. $XDG_CONFIG_HOME/host/default/xinitrc
# Load host specific configuration
[ -f $HOST_CONFIG_DIR/xinitrc ] && . $HOST_CONFIG_DIR/xinitrc

echo $DPI
echo $UI_FONT_SIZE
# DPI and UI_FONT_SIZE are host specific
export DPI
export UI_FONT_SIZE
export UI_FONT_FAMILY='systemui'
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
[ -f $HOST_CONFIG_DIR/xrandr ] && . $HOST_CONFIG_DIR/xrandr

# Set keyboard
exec setkeyboard &
# Configure Logitech Trackman Marble
#exec $XDG_CONFIG_HOME/trackman_marble/trackman-marble_xinput.sh
# Disable Beeps
xset -b
# Hide mouse cursor when idle
exec unclutter &

#---- Xresources ---------------------------------------------------------------
loadxresources

#---- Startup Applications -----------------------------------------------------

if [ "$WM" = "i3" ] ; then
	exec /usr/bin/udiskie -t &
	exec /usr/bin/nm-applet &
	exec /usr/bin/syncthing-gtk -m &
fi

# Import DISPLAY from environemtn for Xapplication services (e.g. dunst)
#systemctl --user import-environment DISPLAY XAUTHORITY

#---- Window Manager -----------------------------------------------------------
# Set Window Manger Name to be recogonized by Java
wmname gnome
exec $WM
