sudo apt-get install bluez pulseaudio-module-bluetooth python-gobject python-gobject-2 -y
sudo usermod -a -G lp pi

sudo sed -i '/\[General\]/c\\[General\]\nEnable=Source,Sink,Media,Socket' /etc/bluetooth/audio.conf
sudo sed -i '/; resample-method = speex-float-3/c\resample-method = trivial' /etc/pulse/daemon.conf

sudo git clone https://github.com/gpduck/bluetoothradio /root/bluetoothradio
sudo cp /root/bluetoothradio/bluetooth-server.service /etc/systemd/system
sudo cp /root/bluetoothradio/systemd-logind.service /etc/systemd/system
sudo cp /root/bluetoothradio/pulseaudio.service /etc/systemd/system
sudo cp /root/bluetoothradio/bluetooth-agent.service /etc/systemd/system
sudo systemctl enable bluetooth-server.service
sudo systemctl enable pulseaudio.service
sudo update-rc.d pulseaudio disable
