#!/bin/sh

cp /etc/environment /etc/environment.original
echo "GTK_IM_MODULE=cedilla" | sudo tee -a /etc/environment
