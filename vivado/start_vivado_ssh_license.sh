#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Please provide your GitHub username as an argument'
    exit 0
fi

# connect to server
ssh -f -N -L 2100:127.0.0.1:2100 -L 2101:127.0.0.1:2101 $1@204.238.213.107

# set the license server location
export XILINXD_LICENSE_FILE=2100@127.0.0.1

# start vivado
while true; do
    read -p "Do you want to start Vivado?" yn
    case $yn in
        [Yy]* ) source $VIVADO/settings64.sh; $VIVADO/bin/vivado; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
