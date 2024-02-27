/* bash */ ''
spaces() {
	local workspaces
	local start
	local end

	workspaces=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries' | grep -v ' *"-' | sed '/{\|}/d' | sort)

    end="$(echo "$workspaces" | tail -n 1 | awk -F '"' '{ print $2 }')"

    workspaces="$(
        echo "{"
        echo "$workspaces" | head -n -1 | sed 's|\([^,]\)$|\1,|'
        echo "$workspaces" | tail -n 1 | sed 's|,$||'
        echo "}"
    )"

	seq "1" "$end" | jq --argjson windows "$workspaces" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})'
}

spaces

socat -u "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r line; do
	spaces
done
''
