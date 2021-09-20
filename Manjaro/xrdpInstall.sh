#!/bin/sh
sudo pacman -Syu --needed base-devel git yay
yay -S xorgxrdp-git

systemctl enable xrdp.service
systemctl enable xrdp-sesman.service

sudo cp /etc/X11/Xwrapper.config /etc/X11/Xwrapper.config.original
echo "allowed_users=anybody" | sudo tee -a /etc/X11/Xwrapper.config

sudo cp ~/.xinitrc ~/.xinitrc.original
sed -i '$ d' ~/.xinitrc
echo "dbus-launch startxfce4" | sudo tee -a ~/.xinitrc

systemctl start xrdp.service
systemctl start xrdp-sesman.service

systemctl status xrdp
systemctl status xrdp-sesman.service

ip a
