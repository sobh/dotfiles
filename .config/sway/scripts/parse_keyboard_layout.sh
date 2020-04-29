#!/bin/sh
cat /dev/stdin	| \
jq --raw-output \
    '[.[] | select(.type == "keyboard")] | first
    | .xkb_active_layout_name
    | split(" ") | first
    | sub("English"; "us")
    | sub("Arabic"; "ara")'


