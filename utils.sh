#!/bin/sh

backupOrCreate () {
    if [ -f $1 ]
    then
        backup $1
    else
        echo "Creating the $1 file."
        sudo touch $1
    fi
}

backup () {
    if [ -f $1 ]
    then
        echo "Creating the backup of the $1 file."
        sudo cp $1 $1.original
    else
        echo "The $1 file do not exist."
    fi
}

overwrite () {
    yes | sudo cp $1 $2
}

appendTo () {
    echo $2 | sudo tee -a $1
}

replaceString () {
    local filename=$1
    local search=$2
    local replace=$3
    sed -i "s/$search/$replace/" $filename
}

overclockPi () {
local file=$1
backup $file

cat <<EOF | sudo tee -a $file
#Overclock to 2.147GHz
over_voltage=6
arm_freq=2147
gpu_freq=750
EOF
}
