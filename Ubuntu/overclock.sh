#!/bin/sh

cp /boot/firmware/config.txt /boot/firmware/config.old

cat <<EOF | sudo tee -a /boot/firmware/config.txt
#Overclock to 2.147GHz
over_voltage=6
arm_freq=2147
gpu_freq=750
EOF
