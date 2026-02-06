#!/bin/bash

while true; do

if [ -n "$updates" ]; then     count=$(echo "$updates" | wc -l);     dunstify -u critical -r 9990 "pkgs ($count)" "\n$updates"; fi
done

BAT="/sys/class/power_supply/BAT0"
NOTIF_ID=""

while true; do
    PERC=$(cat $BAT/capacity)
    STATUS=$(cat $BAT/status)

    if [[ "$STATUS" == "Charging" ]]; then
        # Close the previous critical notification
        if [[ -n "$NOTIF_ID" ]]; then
            dunstctl close "$NOTIF_ID"
            NOTIF_ID=""
        fi
    elif [[ "$PERC" -lt 20 ]]; then
        # Send a critical notification if not already sent
        if [[ -z "$NOTIF_ID" ]]; then
            NOTIF_ID=$(dunstify -u critical -r 9999 "Battery Low" "Battery is at ${PERC}%")
        fi
    else
        # Battery above 20%: clear previous critical notification
        if [[ -n "$NOTIF_ID" ]]; then
            dunstctl close "$NOTIF_ID"
            NOTIF_ID=""
        fi
    fi

    sleep 20
done
