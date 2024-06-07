#!/usr/bin/perl -p
#
# Description:  Convert basic pango/html markup to shell escape.
#

# Bold
s|<b>(.*?)</b>|[1m\1[22m|g;
s|<strong>(.*)</strong>|[1m\1[22m|g;
s|<big>(.*)</big>|[1m\1[22m|g;

# Italic
s|<i>(.*)</i>|[3m\1[23m|g;
s|<em>(.*)</em>|[3m\1[23m|g;

# Underline
s|<u>(.*)</u>|[4m\1[24m|g;

# Blink
s|<blink>(.*)</blink>|[5m\1[0m|g;

# Strike
s|<s>(.*)</s>|[9m\1[29m|g;

# Deleted       [2:Dim, 32:Red FG, 102:Bright Red BG ]
s|<del>(.*)</del>|[2;31;101m\1[0m|g;

# Inserted    [1:Bold, 2:Dim, 32:Green FG, 102:Bright Green BG ]
s|<ins>(.*)</ins>|[1;2;32;102m\1[0m|g;


# Catch All
s|</?.*?>||g;

# Character Entities
s|&amp;|&|g;
s|&lt;|<|g;
s|&gt;|>|g;
s|&quot;|"|g;
s|&apos;|'|g;
