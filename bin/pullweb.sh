#!/bin/sh
#
# Description:	Download a website using 'wget'
#

#---- Options ------------------------------------------------------------------
o=''
o="$o --mirror"			# Mirror the website
o="$o --limit-rate=200k"	# Limits Download Rate
o="$o --no-clobber"		# Do not overwrite existing files
o="$o --convert-links"		# Converts links for offline viewing
o="$o --page-requisites"	# Download images, css.
o="$o --adjust-extension"	# Use correct extension for downloaded files.
# Act liks a human!
o="$o --wait=1"			# Wait (in seconds) between retrievals
o="$o --random-wait"		# Random wait between 0.5-1.5*--wait
o="$o --user-agent=Mozilla"	# Use "User-Agent" header
o="$o --execute robots=off"


# echo "wget $o $*"
wget $o "$*"
