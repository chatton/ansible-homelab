#!/bin/bash

vm_ip="${1}"

echo "Configuring new ip of: ${vm_ip}"

# update hosts file directly

rsync /Users/chatton/sync/Sync/backups/portainer_portainer_data-1-8-2022.tar.gz  "root@${vm_ip}:/mnt/hdds/backups/"
rsync /Users/chatton/sync/Sync/backups/linkding_data-1-8-2022.tar.gz  "root@${vm_ip}:/mnt/hdds/backups/"