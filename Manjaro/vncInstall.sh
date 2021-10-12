#!/bin/sh
source ~/Scripts/utils.sh
source ~/Scripts/cupCake.sh

installPackages (){
    Step "Install packages" &&
    sudo pacman -S --needed tigervnc
}

lightdmConfig (){
    local file=/etc/lightdm/lightdm.conf
    Step "Configuring lightdm" &&
    backup $file &&
    appendTo $file "[XDMCPServer]" &&
    appendTo $file "enabled=true" &&
    appendTo $file "port=177"
}

gdmConfig (){
    local file=/etc/gdm/custom.conf
    Step "Configuring gdm" &&
    backup $file &&
    appendTo $file "[xdmcp]" &&
    appendTo $file "Enable=true" &&
    appendTo $file "Port=177"
}

socketConfig (){
    local destination=/etc/systemd/system/xvnc.socket
    Step "Configuring xvnc.socket" &&
    overwrite ./xvnc.socket $destination
}

serviceConfig (){
    local destination=/etc/systemd/system/xvnc@.service
    Step "Configuring xvnc@.service" &&
	overwrite ./xvnc@.service $destination
}

startService (){
    Step "Starting the service" &&
    systemctl enable xvnc.socket --now
}

myIp (){
    Step "Checking Ip address" &&
    ip a
}

Run $0 'askSudo installPackages lightdmConfig gdmConfig socketConfig serviceConfig startService myIp'
