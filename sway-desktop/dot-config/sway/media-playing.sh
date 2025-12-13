#!/usr/bin/env bash
#wpctl status | grep active && (grep 1 /sys/class/power_supply/AC/online) && exit 1 || exit 0
wpctl status | grep active && exit 1 || exit 0
