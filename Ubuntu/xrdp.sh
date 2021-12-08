#!/bin/bash

#---------------------------------------------------#
# Function 3  - Install xRDP Software....
#---------------------------------------------------#

install_xrdp()
{
echo 
/bin/echo -e "\e[1;33m   |-| Installing xRDP packages       \e[0m"

sudo apt-get install xrdp -y
}

#---------------------------------------------------#
# Function 7 - create services .... 
#---------------------------------------------------# 
enable_service() {
echo
/bin/echo -e "\e[1;33m   |-| Creating and configuring xRDP services    \e[0m"
echo
sudo systemctl daemon-reload
sudo systemctl enable xrdp.service
sudo systemctl enable xrdp-sesman.service
sudo systemctl start xrdp
}

#--------------------------------------------------------------------#
# Fucntion 9 - Allow console Access ....(seems optional in u18.04)
#--------------------------------------------------------------------#

allow_console() 
{
echo
/bin/echo -e "\e[1;33m   |-| Configuring Allow Console Access...    \e[0m"
echo
# Checking if Xwrapper file exists
if [ -f /etc/X11/Xwrapper.config ]
then
sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
else
	sudo bash -c "cat >/etc/X11/Xwrapper.config" <<EOF
	allowed_users=anybody
EOF
fi
}

#---------------------------------------------------#
# Function 10 - create policies exceptions .... 
#---------------------------------------------------#
create_polkit()
{
echo
/bin/echo -e "\e[1;33m   |-| Creating Polkit exceptions rules...    \e[0m"
echo


#All Ubuntu versions,Debian Version, Pop OS version
sudo bash -c "cat >/etc/polkit-1/localauthority/50-local.d/45-allow.colord.pkla" <<EOF
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
EOF
}

#---------------------------------------------------#
# Function 14 - Fix SSL Minor Issue .... 
#---------------------------------------------------#
fix_ssl() 
{ 
echo 
/bin/echo -e "\e[1;33m   |-| Fixing SSL Permissions settings...       \e[0m" 
echo 
if id -Gn xrdp | grep ssl-cert 
then 
/bin/echo -e "\e[1;32m   !--xrdp already member ssl-cert...Skipping ---!\e[0m" 
else
	sudo adduser xrdp ssl-cert 
fi
}

#---------------------------------------------------#
# Function 15 - Fixing env variables in XRDP .... 
#---------------------------------------------------#
fix_env()
{
echo 
/bin/echo -e "\e[1;33m   |-| Fixing xRDP env Variables...       \e[0m" 
echo 
#Add this line to /etc/pam.d/xrdp-sesman if not present
if grep -Fxq "session required pam_env.so readenv=1 user_readenv=0" /etc/pam.d/xrdp-sesman 
   then
            echo "Env settings already set"
   else
		sudo sed -i '1 a session required pam_env.so readenv=1 user_readenv=0' /etc/pam.d/xrdp-sesman
 fi
}

install_xrdp
allow_console
create_polkit
fix_ssl
fix_env
