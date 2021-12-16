#!/bin/sh

backupOrCreate(){
    if [ -f $1 ]
    then
        backup $1
    else
        echo "Creating the $1 file."
        sudo touch $1
    fi
}

backup(){
    if [ -f $1 ]
    then
        echo "Creating the backup of the $1 file."
        sudo cp $1 $1.original
    else
        echo "The $1 file do not exist."
    fi
}

overwrite(){
    yes | sudo cp $1 $2
    echo "The $2 is in place"
}

appendTo(){
    echo $2 | sudo tee -a $1
}

replaceString() {
    local filename=$1
    local search=$2
    local replace=$3
    sudo sed -i "s/$search/$replace/" $filename
    echo "The $filename was updated"
}

serviceStatus(){
    echo "Service $1 is `systemctl is-active $1`"
}

overclockPi(){
local file=$1
backup $file

cat <<EOF | sudo tee -a $file

#Overclock to 2.147GHz
over_voltage=6
arm_freq=2147
gpu_freq=750
EOF
}

get_session(){
    PS3="Select an option: "
    local dbus_args=(--sh-syntax)

    select opt in awesome bspwm budgie cinnamon deepin enlightenment fluxbox gnome i3 jwm kde lxde lxqt mate openbox xfce; do

        case $opt in
            awesome) dbus_args+=(awesome);break ;;
            bspwm) dbus_args+=(bspwm-session);break ;;
            budgie) dbus_args+=(budgie-desktop);break ;;
            cinnamon) dbus_args+=(cinnamon-session);break ;;
            deepin) dbus_args+=(startdde);break ;;
            enlightenment) dbus_args+=(enlightenment_start);break ;;
            fluxbox) dbus_args+=(startfluxbox);break ;;
            gnome) dbus_args+=(gnome-session);break ;;
            i3) dbus_args+=(i3 --shmlog-size 0);break ;;
            jwm) dbus_args+=(jwm);break ;;
            kde) dbus_args+=(startplasma-x11);break ;;
            lxde) dbus_args+=(startlxde);break ;;
            lxqt) dbus_args+=(lxqt-session);break ;;
            mate) dbus_args+=(mate-session);break ;;
            openbox) dbus_args+=(openbox-session);break ;;
            xfce) dbus_args+=(xfce4-session);break ;;
        esac

    done

    echo "dbus-launch ${dbus_args[*]}"
}
