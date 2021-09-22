#!/bin/sh

sudo echo "Applying overclock patch"
sudo cp /boot/config.txt /boot/config.txt.original

cat <<EOF | sudo tee -a /boot/config.txt
#Overclock to 2.147GHz
over_voltage=6
arm_freq=2147
gpu_freq=750
EOF
