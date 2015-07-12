sudo apt-get install bluez pulseaudio-module-bluetooth python-gobject python-gobject-2 -y
sudo usermod -a -G lp pi

sudo sed -i '/\[General\]/c\\[General\]\nEnable=Source,Sink,Media,Socket' /etc/bluetooth/audio.conf
sudo sed -i '/; resample-method = speex-float-3/c\resample-method = trivial' /etc/pulse/daemon.conf

sudo cp bluetooth-server.service /etc/systemd/system
sudo cp systemd-logind.service /etc/systemd/system
sudo cp pulseaudio.service /etc/systemd/system
sudo cp bluetooth-agent.service /etc/systemd/system
sudo systemctl enable bluetooth-server.service
sudo systemctl enable pulseaudio.service
sudo update-rc.d pulseaudio disable