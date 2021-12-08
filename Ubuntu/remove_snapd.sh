#!/bin/bash

sudo systemctl stop snapd
sudo apt remove --purge --assume-yes snapd gnome-software-plugin-snap
rm -rf ~/snap/
sudo rm -rf /var/cache/snapd/ 
