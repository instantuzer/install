BATTERY="/sys/class/power_supply/BAT0"

while true; do
    PERC=$(cat "$BATTERY/capacity")
    STATUS=$(cat "$BATTERY/status")

    # Only notify when discharging and below 15%
    if [[ "$STATUS" == "Discharging" && "$PERC" -le 15 ]]; then
        notify-send -u critical -i battery-empty "Battery Low" "$PERC% remaining!"
    fi

    sleep 20  # check every 20 seconds
done
