#!/bin/sh
#
# Description:	Prints a sequency of UTF characters using a starting code point,
#		and count.
#

START_CHAR=${1:-0x1F600}	# 😀

COUNT=${2:-10}
COUNT=$(( $COUNT - 1 ))

for i in $(seq 0 $COUNT ); do
	char_num=$(( $i + START_CHAR ))
	char=$(printf '\\U%08X' $char_num)
	printf "U+%08X = $char\n" $char_num
done
