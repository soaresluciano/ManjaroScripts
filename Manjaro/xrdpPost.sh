#!/bin/sh
systemctl enable xrdp.service
systemctl enable xrdp-sesman.service

sudo cp /etc/X11/Xwrapper.config /etc/X11/Xwrapper.config.original
echo "allowed_users=anybody" | sudo tee -a /etc/X11/Xwrapper.config

#sudo cp ~/.xinitrc ~/.xinitrc.original
#sed -i '$ d' ~/.xinitrc

cp /etc/X11/xinit/xinitrc ~/.xinitrc
echo "dbus-launch startxfce4" | sudo tee -a ~/.xinitrc

systemctl start xrdp.service
systemctl start xrdp-sesman.service

#systemctl status xrdp
#systemctl status xrdp-sesman.service
