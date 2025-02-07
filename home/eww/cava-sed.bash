empty=" "
full="${chars:$(echo "$charct - 1" | bc):1}"

line=$linect

rm "$cavasedfile"
touch "$cavasedfile"

while [ "$line" -gt 0 ]; do
    line=$((line-1))
    
    i=$linect
    while [ "$i" -gt 0 ]; do
        i=$((i-1))
        
        j=$charct
        while [ "$j" -gt 0 ]; do
            j=$((j-1))

            num=$((i*charct+j))
            echo -n "s|$num;|" >> "$cavasedfile"

            if [ $i -lt $line ]; then
                echo -n "$empty" >> "$cavasedfile"
            elif [ $i = $line ]; then
                echo -n "${chars:$j:1}" >> "$cavasedfile"
            else
                echo -n "$full" >> "$cavasedfile"
            fi

            echo -n "|g;" >> "$cavasedfile"
        done
    done

    echo >> "$cavasedfile"
done
