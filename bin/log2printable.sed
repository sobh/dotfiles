#!/usr/bin/sed -Ef
#
# Description:  Filter keyboard log created by logkeys to only printable
#               characters
# Note:         Instead of removing patterns, we substitute them with a new
#               line. Otherwise, their removal would introduce, erroneous
#               n-grams.
#

# Remove Time Stamps
/^Logging st/d
s/^[0-9]{4}-[0-9]{2}-[0-9]{2} *[0-9]{2}:[0-9]{2}:[0-9]{2}\+[0-9]{4} *> *//g

# Reduce the impact of vim 'hjkl'
s/[hjkl]{3,}/\n/g

# Convert the <Enter> tag to an actual new line
s/<Enter>/\n/g
s/<Tab>/\t/g

# Modifiers
s/<[RL]+Meta>/\n/g
s/<[RL]+Ctrl>/\n/g
s/<[LR]+Shft>/\n/g
s/<[LR]?Alt(Gr)?>/\n/g
# Modifiers Keys Releases
s/<#\+[0-9]+>/\n/g

# Functions Keys
s/<F[0-9]{,2}>/\n/g

# Remove the Control Characters tags
s/<(Esc|BckSp|Del|Up|Down|Right|Left|PgDn|PgUp|End|PrtSc|CpsLk|Home|NumLk|ScrLk|Ins|Menu|Pause)>/\n/g

# Weird stuff that I don't where it came from
s/<KP([0-9]{,2}|Ent|\W)>/\n/g
s/<E-.?[1-9]{0,2}.?>/\n/g
