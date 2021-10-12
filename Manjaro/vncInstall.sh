#!/bin/sh
source ~/Scripts/utils.sh
source ~/Scripts/cupCake.sh

installPackages (){
    Step "Install packages" &&
    pacman -S --needed tigervnc
}

lightdmConfig (){
    local file=/etc/lightdm/lightdm.conf
	local txt= "" \
	"[XDMCPServer]" \
	"enabled=true" \
	"port=177" \
    Step "Configuring lightdm" &&
    backup $file &&
    appendTo $file txt
}

gdmConfig (){
    local file=/etc/gdm/custom.conf
	local txt= "" \
	"[xdmcp]" \
	"Enable=true" \
	"Port=177" \
    Step "Configuring gdm" &&
    backup $file &&
    appendTo $file txt
}

socketConfig (){
    local destination=/etc/systemd/system/xvnc.socket
    Step "Configuring xvnc.socket" &&
    overwrite ./xvnc.socket $destination
}

serviceConfig (){
    local file=/etc/systemd/system/xvnc@.service
    Step "Configuring xvnc@.service" &&
	overwrite ./xvnc@.service $destination
}

startService (){
    Step "Starting the service" &&
    systemctl enable xvnc.socket --now &&
}

serviceStatus (){
    Step "Checking the service status" &&
    serviceStatus xvnc.socket
}

myIp (){
    Step "Checking Ip address" &&
    ip a
}

Run $0 'askSudo installPackages lightdmConfig gdmConfig socketConfig serviceConfig startService serviceStatus myIp'
