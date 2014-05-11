#!/bin/bash
# Load a bluetooth agent to allow the pairing and connection, and to
# Set pulseaudio up against the bluetooth connection.
DIR=$( readlink -f "$( dirname "$0" )")
hciconfig hci0 up
bluetooth-agent $(cat $DIR/bluetoothPin)
