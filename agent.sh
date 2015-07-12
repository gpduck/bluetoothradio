#!/bin/bash
# Load a bluetooth agent to allow the pairing and connection, and to
# Set pulseaudio up against the bluetooth connection.
hciconfig hci0 up
bt-agent -p /etc/bluetooth/bluetoothPin -c NoInputNoOutput
