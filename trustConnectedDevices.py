#!/usr/bin/python

import gobject

import sys
import dbus
from dbus.mainloop.glib import DBusGMainLoop

DBusGMainLoop(set_as_default=True)

loop = gobject.MainLoop()
loop.run()

dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
bus = dbus.SystemBus()
manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")

adapter = dbus.Interface(bus.get_object("org.bluez", manager.DefaultAdapter()), "org.bluez.Adapter")

for path in adapter.ListDevices():
	device = dbus.Interface(bus.get_object("org.bluez", path), "org.bluez.Device")
	if( device.GetProperties()["Trusted"] == 0 ):
		device.SetProperty("Trusted", dbus.Boolean(1))