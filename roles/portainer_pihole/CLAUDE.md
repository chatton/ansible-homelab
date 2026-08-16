# portainer_pihole

## Purpose

Deploys Pi-hole, network-wide DNS ad-blocking. This is core network infrastructure - if it's down, DNS resolution for the whole network is affected.

## Managed image(s)

- `pihole/pihole` via `pihole_tag` (currently `2024.07.0`) - https://github.com/pi-hole/docker-pi-hole/releases

## Known upgrade constraints

None documented yet.

## Other notes

Treat upgrades/restarts of this service with extra caution given the blast radius (network-wide DNS) - call out any expected downtime in the PR.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

