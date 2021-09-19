#!/bin/sh
sudo cp /etc/X11/Xwrapper.config /etc/X11/Xwrapper.config.original
echo "allowed_users=anybody" | sudo tee -a /etc/X11/Xwrapper.config

sudo cp ~/.xinitrc ~/.xinitrc.original
echo "dbus-launch startxfce4" | sudo tee -a ~/.xinitrc

systemctl enable xrdp.service
systemctl enable xrdp-sesman.service
