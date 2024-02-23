hyprctl dispatch focuswindow address:"$(hyprctl -j clients | jq -r '.[]|select(.address != ""  and .title != "")|(.class + "\t" + .address + "\t" + .title)' | wofi --show dmenu | cut -f2)"
