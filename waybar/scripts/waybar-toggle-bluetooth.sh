#! /usr/bin/env bash

power_on() {
	if bluetoothctl show | grep -q "Powered: yes"; then
		return 0
	else
		return 1
	fi
}

if power_on; then
	bluetoothctl power off
else
	bluetoothctl power on
fi
