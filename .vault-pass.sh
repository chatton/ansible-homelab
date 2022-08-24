#!/bin/bash
# fetch vault password from bitwarden. We assume there is an item called "homelab-vault" that contains the password
password="$(bw list items | jq -r 'map(select(.name == "homelab-vault"))[0].login.password')"
echo "${password}"
