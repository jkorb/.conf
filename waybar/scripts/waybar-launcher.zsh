#! /usr/bin/env bash

trap "killall waybar" EXIT

logger -i "$0: Starting waybar in the background..."

until waybar; do
  logger -i "$0: Waybar failed. Restarting..."
  sleep 1
done
