#!/bin/sh
#

#---- Libraries ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
. ~/lib/sh/color.sh

# Arguments
keyscount_fname="$1"
layout_fname="$2"
[ -z "$layout_fname" ] && layout_fname="/dev/stdin"


# If the layout is in the 'genkey' layout file format, extract the keys only.
layout_raw=$(cat $layout_fname)
layout_line_count=$(wc -l <<< "$layout_raw")
if [ $layout_line_count -gt 4 ]; then
	echo "Heatmap for Layout: $(head -1 <<< $layout_raw)"
	b=$(bc <<< $layout_line_count/2)
	t=$(bc <<< $b+1)
	layout_raw=$(head -n $t <<< $layout_raw | tail -n $b)
fi

layout=$(sed 's|\\|\\\\|g' <<< $layout_raw)
stats=$(
	while read key; do
		grep -Fia "$key" $keyscount_fname | sed 's/^[[:blank:]]*//'
	done <<< $(tr -s ' ' '\n' <<< "$layout"| sort | uniq)
)

# We use the key with the maximum count to normalize the "heat" of each key.
MAX_COUNT=$(cut -d ' ' -f1 <<< $stats | sort -rn | head -1)

# echo "Max Count=$MAX_COUNT"
# echo "$layout"
# Print Layout
while read row; do
	box_size=3
	for box_line in $(seq $box_size); do
		while read key; do
			key=$(tr '[:lower:]'  '[:upper:]' <<< "$key" )
			count=$(grep -Fia "$key" <<< $stats | cut -d ' ' -f1 )
			heat=$(echo "(255*$count)/$MAX_COUNT" | bc)
			color_bg_rgb $heat
			[ $heat -gt 128 ] && color_fg_rgb 0 || color_fg_rgb 255
			[ $box_line -eq 1 ] && printf "       "
			[ $box_line -eq 2 ] && printf "   %s   "  "$key"
			[ $box_line -eq 3 ] && printf "       "

			# [ $box_line -eq 1 ] && printf "┌─────┐"
			# [ $box_line -eq 2 ] && printf "│  %s  │"  "$key"
			# [ $box_line -eq 3 ] && printf "└─────┘"
		done <<< $(tr -s ' ' '\n' <<< "$row" | sed 's|\\|\\\\|g' )
		color_reset
		echo ''
	done
done <<< "$layout"


			# printf "Key %s\tCount=%8d\tHeat=%3d" "$key" $count $heat
			# echo
			# continue
			#
