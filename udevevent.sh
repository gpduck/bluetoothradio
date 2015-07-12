#!/bin/bash

hci="$(echo $0 | grep -o "hci[0-9]\+")"
dbus="$(qdbus --system org.bluez | grep -m 1 "${hci}/dev_")"
mac="$(echo $dbus | rev | cut -c -17 | rev)"
bluezSource="bluez_source.${mac}"
case "$ACTION" in
	add)
		pactl "set-sink-mute 0 1"

		pactl "set-sink-mute 0 0"
		pactl set-sink-volume 0 100%
		
		# Return Example: alsa_output.pci-0000_00_10.1.analog-stereo
		alsaSink="$(pactl list | grep -m 1 "Name: alsa_output" | cut -c 8-)"
		
		# Return Example: 25
		pactl load-module module-loopback source=${bluezSource} sink=${alsaSink}
		;;
	remove)
		pactl unload-module module-loopback
		;;
esac