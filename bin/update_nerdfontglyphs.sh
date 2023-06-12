#!/usr/bin/sh
#
# Description:  Update the list of Nerd Font Glyphs.
#

# ---- Contants ----------------------------------------------------------------
NF_GLYPH_CACHE_FNAME=$XDG_CACHE_HOME/nerd-fonts/nerd-fonts-glyphs.cache.txt
NF_GLYPH_DATA_FNAME=$XDG_DATA_HOME/glyphs/nerd-fonts.txt

NF_BASE_URL="https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/bin/scripts/lib"
NF_GLYPH_FILES="
i_cod.sh
i_dev.sh
i_fae.sh
i_fa.sh
i_iec.sh
i_logos.sh
i_md.sh
i_oct.sh
i_ple.sh
i_pom.sh
i_seti.sh
i_weather.sh
"

# ---- Main --------------------------------------------------------------------

# Grab the files containing the glyphs, pipe them to the filters, then to the
# target file.

if [ "$1" = '-r' ]; then
	echo "Updating cache file." 1>&2
	mkdir -p $(dirname "$NF_GLYPH_CACHE_FNAME") 2>/dev/null 1>&2
	{
		for file in $NF_GLYPH_FILES; do
			echo "Caching File: $file" 1>&2
			url="$NF_BASE_URL/$file"
			curl $url
		done
	} > "$NF_GLYPH_CACHE_FNAME"
fi

# Clean the cache file, and save it.
# A typical line looks like
# i='<GLYPH>' i_seti_salesforce=$i
grep "^i"  "$NF_GLYPH_CACHE_FNAME" |
	sed -E "s/.*'(.+)'.*i_([^_]*)_(.*)=.*/\1 :nerd:\2: \3/" |
	tr '_' ' '| tee $NF_GLYPH_DATA_FNAME

