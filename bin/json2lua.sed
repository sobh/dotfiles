#!/usr/bin/sed -Ef
1i return
s/"(\S+)"\s*:/\1 =/g
s/\[/{/g
s/\]/}/g
