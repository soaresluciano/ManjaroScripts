#!/bin/sh

xrdp_fix_ssl() 
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


xrdp_fix_env()
{
echo 
/bin/echo -e "\e[1;33m   |-| Fixing xRDP env Variables...       \e[0m" 
echo 

if grep -Fxq "session required pam_env.so readenv=1 user_readenv=0" /etc/pam.d/xrdp-sesman 
   then
            echo "Env settings already set"
   else
		sudo sed -i '1 a session required pam_env.so readenv=1 user_readenv=0' /etc/pam.d/xrdp-sesman
 fi
}


xrdp_enable_service() {
echo
/bin/echo -e "\e[1;33m   |-| Creating and configuring xRDP services    \e[0m"
echo
sudo systemctl daemon-reload
sudo systemctl enable xrdp.service
sudo systemctl enable xrdp-sesman.service
sudo systemctl start xrdp
}
