sudo apt-get install bluez bluez-tools pulseaudio-module-bluetooth python-gobject python-gobject-2 -y
sudo adduser pulse audio
sudo adduser pulse lp
sudo adduser root pulse-access

sudo sed -i '/\[General\]/c\\[General\]\nEnable=Source,Sink,Media,Socket' /etc/bluetooth/audio.conf
sudo sed -i '/; resample-method = speex-float-3/c\resample-method = trivial' /etc/pulse/daemon.conf

cp /etc/pulse/system.pa /tmp/system.pa
cat << EOF >> /tmp/system.pa

.ifexists module-bluetooth-discover.so
  load-module module-bluetooth-discover
.endif

.ifexists module-bluetooth-policy.so
  load-module module-bluetooth-policy
.endif
EOF
sudo mv /tmp/system.pa /etc/pulse/system.pa

sudo mkdir /usr/lib/bluetoothradio
sudo cp agent.sh /usr/lib/bluetoothradio/
sudo mkdir /etc/bluetoothradio
sudo cp bluetoothPin /etc/bluetoothradio/
sudo cp bluetooth-agent.service /etc/systemd/system


sudo cp systemd-logind.service /etc/systemd/system

sudo cp pulseaudio.service /etc/systemd/system

sudo systemctl enable pulseaudio.service
sudo systemctl enable bluetooth-agent.service