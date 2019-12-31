#!/bin/bash
#
# Disable Cloud-init/network-config script
#
#
# Copyright (c) 2019 SMD. Released under the MIT License.


read -p "Do you really want to disable cloud-init auto network configuration? [y/N]: " sure
if [[ !("$sure" =~ ^[yY]*$ || "$sure" = 'yes') || -z "$sure" ]]; then
        echo "Script aborted.";
        exit
fi
sudo echo "network: {config: disabled}" > /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
echo -e "Auto network configuration via cloud-init disable."
read -p "Do you want to keep current network configurations? [y/N]: " keep
if [[ ("$keep" =~ ^[yY]*$ || "$keep" = "yes") && -n "$keep" ]]; then
        sudo cp /etc/cloud/cloud.cfg.d/50-curtin-networking.cfg /etc/netplan/50-cloud-init.yaml
        echo 'Current network configuration copied to /etc/netplan/'
fi

sudo echo "network:
    config: disabled" > /etc/cloud/cloud.cfg.d/50-curtin-networking.cfg
echo "Cloud-init auto configuration disabled."
