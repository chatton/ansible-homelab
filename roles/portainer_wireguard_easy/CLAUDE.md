# portainer_wireguard_easy

## Purpose

Deploys wg-easy, a WireGuard VPN server with a web UI.

## Managed image(s)

- `ghcr.io/wg-easy/wg-easy` via `wireguard_easy_tag` (currently `13`) - https://github.com/wg-easy/wg-easy/releases

## Known upgrade constraints

None documented yet.

## Other notes

This is the VPN entrypoint into the homelab network - treat upgrades cautiously and confirm connectivity isn't broken after a bump.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

