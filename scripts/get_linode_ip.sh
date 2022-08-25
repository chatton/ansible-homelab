#!/bin/bash
linode_ip="$(ansible-inventory -i linode.yml --list | jq ._meta.hostvars | jq '."simple-linode"' | jq -r .ipv4[0])"
inventory_entry="root@${linode_ip}"
echo $inventory_entry

echo "[servers]" > linodehosts.ini
echo "${inventory_entry}" >> linodehosts.ini
