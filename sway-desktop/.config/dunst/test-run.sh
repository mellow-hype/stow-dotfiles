#!/usr/bin/env bash

dunstctl reload
dunstify -u low "low urgency" "test message"
sleep 1
dunstify -u normal "normal urgency" "test message"
sleep 1
dunstify -u critical "critical urgency" "test message"
sleep 1

