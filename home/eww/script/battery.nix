/* bash */ ''
percent="$(acpi -b | awk -F ', ' '{ print $2 }')"
timestamp="$(acpi -b | awk -F ', ' '{ print $3 }' | awk '{ print $1 }' )"
hour="$(echo "$timestamp" | awk -F ':' '{ print $1 }')"
min="$(echo "$timestamp" | awk -F ':' '{ print $2 }')"
sec="$(echo "$timestamp" | awk -F ':' '{ print $3 }')"

direction="$(acpi -b | sed -e 's|^Battery .: ||' -e 's|, .*||')"

timeinfo="$(
[ "$direction" == "Charging" ] && echo -n "+"
[ "$direction" == "Discharging" ] && echo -n "-"

if [[ $min -le 0 ]]; then
    echo "$sec"s
elif [[ $hour -le 0 ]]; then
    math="$min + $sec/60"
    time="$(bc <<< "scale = 1; $math")"
    [ "$(echo "$time" | wc --chars)" -gt 4 ] && time="$(bc <<< "$math")" # wc counts \n
    echo "$time"m
else
    math="$hour + $min/60"
    time="$(bc <<< "scale = 1; $math")"
    [ "$(echo "$time" | wc --chars)" -gt 4 ] && time="$(bc <<< "$math")"
    echo "$time"h
fi
)"

echo "$percent ($timeinfo)"
''
