#!/bin/sh
#
# Description:	Terminal Colors
#

#---- Helper Functions ---------------------------------------------------------
_source_script ()
{
	fname="$1"
	command -v $fname >/dev/null 2>&1 && { . $fname             ; return 0; }
	[ -e $fname ]                     && { . ./$fname           ; return 0; }
	[ -e $HOME/lib/sh/$fname ]        && { . $HOME/lib/sh/$fname; return 0; }

	echo "Error: Unable to load script, please add the shell libraries'\
	directory to the \$PATH."
	return 1;
}

#---- Includes -----------------------------------------------------------------
_source_script "escape.sh"

#---- Functions ----------------------------------------------------------------
color_reset()
{
	printf $RESET
}

color_bg_reset()
{
	printf $BG_DEFAULT
}

color_bg_rgb()
{
	R=$1
	G=${2:-$1}
	B=${3:-$1}
	printf "$ESC[48;2;$R;$G;${B}m"
}

color_bg_256()
{
	C=$1
	printf "$ESC[48;5;${C}m"
}

color_fg_rgb()
{
	R=$1
	G=${2:-$1}
	B=${3:-$1}
	printf "$ESC[38;2;$R;$G;${B}m"
}

color_fg_256()
{
	C=$1
	printf "$ESC[38;5;${C}m"
}
color_fg_reset()
{
	printf $FG_DEFAULT
}


#---- Test ---------------------------------------------------------------------
_test_color()
{
	echo "Test 256 colors."
	echo "----------------"
	echo "Standard Colors:"
	for c in $(seq 0 15); do
		color_bg_256 $c
		printf " %03d " $c
	done
	echo ""
	echo "216 Colors:"
	for c in $(seq 16 231); do
		color_bg_256 $c
		printf " %03d " $c
		color_reset
		[ $(( (c-15)%36 )) -eq 0 ] && echo
	done
	echo "Grayscale Colors:"
	for c in $(seq 232 255); do
		color_bg_256 $c
		printf " %03d " $c
	done
	color_reset
	echo ""

	range=$(seq 0 24 255)
	echo "Taste the Rainbow..."
	for r in $range; do
		for g in $range; do
			for b in $range; do
				color_bg_rgb $r $g $b
				printf ' '
				color_bg_reset
			done
			echo ''
		done
	done

}

# If script is executed, and not source, execute the test function.
[ `basename "$0"` = 'color.sh' ] && _test_color
