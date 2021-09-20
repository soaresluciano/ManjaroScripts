#!/bin/sh

sudo pacman -Syu --needed open-vm-tools xf86-input-vmmouse xf86-video-vmware mesa gtk2 gtkmm

sudo cp /etc/environment /etc/environment.original
echo "needs_root_rights=yes" | sudo tee -a /etc/environment

systemctl --now enable vmtoolsd
sudo systemctl restart vmtoolsd
