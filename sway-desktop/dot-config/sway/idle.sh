#!/usr/bin/env bash

let LOCK_TIMEOUT=600
let DPMS_TIMEOUT=900
IDLE=~/.config/sway/

LOCKCMD="swaylock"
DPMS_ON='swaymsg "output * dpms on"'
DPMS_OFF='swaymsg "output * dpms off"'

swayidle \
    timeout "$LOCK_TIMEOUT"   "$IDLE/media-playing.sh && $LOCKCMD" \
    timeout "$DPMS_TIMEOUT"   "$IDLE/media-playing.sh && $DPMS_OFF" resume  "$DPMS_ON" \
    before-sleep "$LOCKCMD"
