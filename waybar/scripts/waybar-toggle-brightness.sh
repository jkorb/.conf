#! /usr/bin/env bash

max_bright=24242

cur_bright="$(brightnessctl -q -d intel_backlight get)"

if [[ $cur_bright -lt $max_bright ]]; then
	brightnessctl -q -d intel_backlight set 100%
else
	brightnessctl -q -d intel_backlight set 50%
fi
