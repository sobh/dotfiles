#!/bin/dash

#---- Functions ----------------------------------------------------------------
pad=10
print_count()
{
	key=$1
	key_ex=$2
	fname="$3"
	[ -z "$fname" ] && fname="/dev/stdin"

	count=$(grep -Eao "$key_ex" < $fname | wc -l)
	printf "%${pad}d %s\n" "$count" "$key"
}

#---- Parameters ---------------------------------------------------------------
myname=$(basename $0)
keylog=$(mktemp /tmp/$myname.XXXXX)
printable=$(mktemp /tmp/$myname.XXXXX)
modkeys=$(mktemp /tmp/$myname.XXXXX)
commonkeys=$(mktemp /tmp/$myname.XXXXX)
symbolkeys=$(mktemp /tmp/$myname.XXXXX)
digitkeys=$(mktemp /tmp/$myname.XXXXX)
letterkeys=$(mktemp /tmp/$myname.XXXXX)


#---- Main ---------------------------------------------------------------------
# Copy keys' log, and remove timestamps
doas cp /var/log/logkeys.log $keylog
# doas tail -n5000 /var/log/logkeys.log > $keylog
sed -e '/^Logging st/d' -i $keylog
sed -e 's/^.* > //g' -i $keylog
log2printable.sed < $keylog > $printable

# Mod Keys
print_count 'Shift' '<.Shft>' < $keylog > $modkeys
print_count 'Ctrl'  '<.Ctrl>' < $keylog >> $modkeys
print_count 'Super' '<.Meta>' < $keylog >> $modkeys
print_count 'Alt'   '<(LAlt|RAlt|AltGr)>' < $keylog >> $modkeys

# Shift Classes Keys
print_count 'Shift+[[:punct:]] (Symbols)' '<.Shft>[[:punct:]]' < $keylog >> $modkeys
print_count 'Shift+[[:digit:]] (Number)'  '<.Shft>[[:digit:]]' < $keylog >> $modkeys
print_count 'Shift+[[:alpha:]] (Letters)' '<.Shft>[[:alpha:]]' < $keylog >> $modkeys

# Multi-Mods
print_count 'Ctrl+Shift'    '(<.Ctrl><.Shft>|<.Shft><.Ctrl>)' < $keylog >> $modkeys
print_count 'Alt+Shift'    '(<.Alt.*><.Shft>|<.Shft><.Alt.*>)' < $keylog >> $modkeys
print_count 'Alt+Ctrl'    '(<.Alt.*><.Ctrl>|<.Ctrl><.Alt.*>)' < $keylog >> $modkeys

print_count 'Super+Shift'   '(<.Shft><.Meta>|<.Meta><.Shft>)' < $keylog >> $modkeys
print_count 'Super+Ctrl'    '(<.Ctrl><.Meta>|<.Meta><.Ctrl>)' < $keylog >> $modkeys
print_count 'Super+Alt'    '(<.Alt.*><.Meta>|<.Meta><.Alt.*>)' < $keylog >> $modkeys

# Common Keys
print_count 'Space'     ' '         < $keylog > $commonkeys
print_count 'Enter'     '<Enter>'   < $keylog >> $commonkeys
print_count 'Backspace' '<BckSp>'   < $keylog >> $commonkeys
print_count 'Tab'       '<Tab>'     < $keylog >> $commonkeys
print_count 'Escape'    '<Esc>'     < $keylog >> $commonkeys
print_count 'Delete'    '<Del>'     < $keylog >> $commonkeys

# print_count 'End'       '<End>' < $keylog >> $commonkeys
# print_count 'Home'      '<Home>' < $keylog >> $commonkeys

# Symbol Keys
symbols="'"' ! " # $ % & ( ) \* + , - . / : ; < = > ? @ [ \\ ] ^ _ ` { | } ~'
for c in $symbols; do
	count=$(tr -cd "$c" < $printable | wc -m)
	printf "%${pad}d %s\n" $count "${c#\\}"  >> $symbolkeys
done

# Numbers
digits='0 1 2 3 4 5 6 7 8 9'
for c in $digits; do
	count=$(tr -cd "$c" < $printable | wc -m)
	printf "%${pad}d $c \n" $count >> $digitkeys
done

# Letters
letters='A B C D E F G H I J K L M N O P Q R S T U V W X Y Z'
for c in $letters; do
	count=$(grep -Fiao "$c" $printable | wc -l)
	printf "%${pad}d $c \n" $count >> $letterkeys
done

#---- Results ------------------------------------------------------------------
if [ "$#" -eq 0 ]; then
	echo "# Mod Keys"
	echo "------------"
	sort --numeric-sort --reverse < $modkeys


	printf "\n\n"
	echo "# Common Keys"
	echo "------------"
	sort --numeric-sort --reverse < $commonkeys


	printf "\n\n"
	echo "# Symbols' Keys"
	echo "----------------"
	sort --numeric-sort --reverse < $symbolkeys

	printf "\n\n"
	echo "# Digits' Keys"
	echo "----------------"
	sort --numeric-sort --reverse < $digitkeys

	printf "\n\n"
	echo "# Letters' Keys"
	echo "----------------"
	sort --numeric-sort --reverse < $letterkeys
else
	case "$1" in
		r|ra|raw)   cat $symbolkeys $digitkeys $letterkeys
			;;
		l)          cat $letterkeys
			;;
		n)          cat $numberkeys
			;;
		s)          cat $symbolkeys
			;;
		*)          cat $symbolkeys $digitkeys $letterkeys
			;;
	esac
fi

#---- Clean-up -----------------------------------------------------------------
rm -f $keylog $modkeys $commonkeys $printable $digitkeys $symbolkeys $letterkeys
