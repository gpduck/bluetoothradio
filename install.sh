sudo apt-get install bluez pulseaudio-module-bluetooth python-gobject python-gobject-2 bluez-tools qdbus git-core -y
sudo usermod -a -G lp pi

sudo sed -i '/\[General\]/c\\[General\]\nEnable=Source,Sink,Media,Socket' /etc/bluetooth/audio.conf
sudo sed -i '/; resample-method = speex-float-3/c\resample-method = trivial' /etc/pulse/daemon.conf

sudo git clone https://github.com/gpduck/bluetoothradio /root
sudo cp /root/bluetoothradio/bluetooth-server.service /etc/systemd/system
sudo systemctl enable bluetooth-server.service
