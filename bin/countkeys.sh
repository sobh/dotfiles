#!/bin/dash
myname=$(basename $0)
keylog=$(mktemp /tmp/$myname.XXXXX)
stats=$(mktemp /tmp/$myname.XXXXX)

doas cp /var/log/logkeys.log $keylog
sed -e 's/^.* > //g' -i $keylog

# Mod Keys
alt_count=$(grep -ao '<\(LAlt\|RAlt\|AltGr\)>' $keylog | wc -l)
ctrl_count=$(grep -ao '<.Ctrl>' $keylog | wc -l)
shift_count=$(grep -ao '<.Shft>' $keylog | wc -l)
super_count=$(grep -ao '<.Meta>' $keylog | wc -l)

# Common Keys
backspace_count=$(grep -ao '<BckSp>' $keylog | wc -l)
delete_count=$(grep -ao '<Del>' $keylog | wc -l)
enter_count=$(grep -ao '<Enter>' $keylog | wc -l)
space_count=$(grep -ao ' ' $keylog | wc -l)

end_count=$(grep -ao '<End>' $keylog | wc -l)
esc_count=$(grep -ao '<\(Esc\|CpsLk\)>' $keylog | wc -l)
home_count=$(grep -ao '<Home>' $keylog | wc -l)
tab_count=$(grep -ao '<Tab>' $keylog | wc -l)

pad=10
printf "%${pad}d Super\n" $super_count > $stats
printf "%${pad}d Alt\n" $alt_count >> $stats
printf "%${pad}d Ctrl\n" $ctrl_count >> $stats
printf "%${pad}d Shift\n" $shift_count >> $stats


printf "%${pad}d Enter\n" $enter_count >> $stats
printf "%${pad}d Space\n" $space_count >> $stats
printf "%${pad}d Backspace\n" $backspace_count >> $stats
printf "%${pad}d Delete\n" $delete_count >> $stats
printf "%${pad}d Escape\n" $esc_count >> $stats
printf "%${pad}d Tab\n" $tab_count >> $stats

# printf "%${pad}d Home\n" $home_count >> $stats
# printf "%${pad}d End\n" $end_count >> $stats
# printf "%${pad}d Delete\n" $delete_count >> $stats

sort --numeric-sort --reverse < $stats


rm -f $keylog $stats
