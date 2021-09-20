#!/bin/sh
sudo apt -y purge deja-dup*
sudo apt -y purge celluloid*
sudo apt -y purge simple-scan*
sudo apt -y purge evolution*
sudo apt -y purge magnus*
sudo apt -y purge plank*
sudo apt -y purge rhythmbox*
sudo apt -y purge orca*
sudo apt -y purge shotwell*
sudo apt -y purge webcamoid*

sudo apt-get clean
sudo apt-get autoremove
