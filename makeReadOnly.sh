#!/bin/sh

#disable swap
sudo dphys-swapfile swapoff
sudo dphys-swapfile uninstall
sudo update-rc.d dphys-swapfile disable

#Configure unionfs
sudo apt-get install unionfs-fuse

cat << EOF > /tmp/mount_unionfs
#!/bin/sh
DIR=$$1


if [ ! -e /tempfs$${DIR} ]
then
  mkdir /tempfs$${DIR}
fi

if [ ! -e $${DIR} ]
then
  mkdir $${DIR}
fi

/usr/bin/unionfs-fuse -o cow,allow_other,nonempty /tempfs${DIR}=RW:${DIR}_ro=RO ${DIR}
EOF

sudo cp /tmp/mount_unionfs /usr/local/bin/mount_unionfs
sudo chmod +x /usr/local/bin/mount_unionfs

sudo cp -al /etc /etc_ro

sudo mv /var /var_ro
sudo mkdir /var
sudo chmod --reference=/var_ro /var
 
sudo mv /home /home_ro
sudo mkdir /home
sudo chmod --reference=/home_ro /home
 
sudo mv /root /root_ro
sudo mkdir /root
sudo chmod --reference=/var_ro /var
 
sudo mv /tmp /tmp_ro
sudo mkdir /tmp /tempfs
sudo chmod --reference=/tmp_ro /tmp

#mark / as read-only
awk '$2~"^/$"&&$4!~"ro"{$4=$4",ro"}1' OFS="\t" /etc/fstab > /tmp/fstab
 
echo "tmpfs\t/tempfs\ttmpfs\tdefaults,size=30M\t0\t0" >> /tmp/fstab
 
echo "mount_unionfs\t/etc\tfuse\tdefaults\t0\t0" >> /tmp/fstab
echo "mount_unionfs\t/var\tfuse\tdefaults\t0\t0" >> /tmp/fstab
echo "mount_unionfs\t/home\tfuse\tdefaults\t0\t0" >> /tmp/fstab
echo "mount_unionfs\t/root\tfuse\tdefaults\t0\t0" >> /tmp/fstab
echo "mount_unionfs\t/tmp\tfuse\tdefaults\t0\t0" >> /tmp/fstab
sudo mv /tmp/fstab /etc/fstab
