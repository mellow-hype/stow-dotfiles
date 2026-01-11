#!/usr/bin/env bash
GREEN="b8bb26"
RED="cc241d"
WHITE="fbf1c7"
BWHITE="ffffff"
BLACK="2e2e2e"
AQUADARK="427b58"

MENU_BG="${WHITE}ff"
MENU_FG="${BLACK}ff"
SELECT_FG="${BWHITE}ff"
SELECT_BG="${GREEN}ff"
MATCH_TX="${RED}ff"
MATCH_FG="${RED}ff"

GREEN_HINT="string:fgcolor:#$GREEN"
RED_HINT="string:fgcolor:#$RED"
NOTIF_ID="1337"

DELAY=5
ACTION=$(printf "lock\nlogout\nreboot\nshutdown" | \
    fuzzel --input-color=$MENU_FG \
    -b $MENU_BG -t $MENU_FG \
    -S $SELECT_FG -s $SELECT_BG \
    -m $MATCH_TX -M $MATCH_FG \
    -w 32 -l 4 -d\
) || exit 0


function do_countdown_notif() {
    local act=$1
    dunstify -r $NOTIF_ID -h "${GREEN_HINT}" -h int:value:100 "$act in $DELAY seconds..."
    for val in $(seq $DELAY); do
        local remain=$(echo "$DELAY - $val" | bc)
        local pc=$(echo "(100/$DELAY) * $remain" | bc)
        dunstify -r $NOTIF_ID -h "${GREEN_HINT}" -h int:value:"$pc" "$act in $remain seconds..."
        [ "$remain" == "0" ] || sleep 1
    done
    # force close the dunst notification now that we're done
    dunstify -C $NOTIF_ID
}



case $ACTION in
    "lock")
        dunstify -t 1000 "Session locking..." && sleep 1
        swaylock
        ;;

    "logout")
        do_countdown_notif "Logging out"
        swaymsg exit
        ;;

    "reboot")
        do_countdown_notif "Rebooting"
        systemctl reboot
        ;;

    "shutdown")
        do_countdown_notif "Shutting down"
        systemctl poweroff
        ;;
    *)
        ;;
esac

