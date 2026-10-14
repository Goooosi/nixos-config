#!/bin/sh
TYPE=$1
VALUE=$2

if [ "$TYPE" = "audio" ]; then
    ICON=""
elif [ "$TYPE" = "mute" ]; then
    ICON=""
elif [ "$TYPE" = "brightness" ]; then
    ICON=""
    CUR=$(cat /sys/class/backlight/amdgpu_bl2/brightness)
    MAX=$(cat /sys/class/backlight/amdgpu_bl2/max_brightness)
    # Use awk to handle precise decimal rounding to the nearest integer
    VALUE=$(awk -v c="$CUR" -v m="$MAX" 'BEGIN {printf "%.0f", (c * 100) / m}')
fi

CLEAN_VALUE=$(echo "$VALUE" | tr -d '\r\n[:space:]')

eww update osd_icon="$ICON" osd_value="$CLEAN_VALUE" osd_text="${CLEAN_VALUE}%"

if ! eww windows | grep -q '^\*osd$'; then
    eww open osd
fi

pkill -f "sleep 4 && eww close osd"
(sleep 4 && eww close osd) &

