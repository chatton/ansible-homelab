# portainer_nextcloud

## Purpose

Deploys Nextcloud, the homelab's file-sync/sharing service.

## Managed image(s)

- `nextcloud` via `nextcloud_tag` (currently `28.0.4`) - https://hub.docker.com/_/nextcloud/tags

## Known upgrade constraints

Nextcloud does not support skipping a major version - upgrades must go one major version at a time (enforced by Nextcloud itself; it will refuse to start otherwise). See https://docs.nextcloud.com/server/latest/admin_manual/maintenance/upgrade.html. Before/after a major bump, the `occ upgrade` maintenance command and a maintenance-mode window are typically required - call this out explicitly as a manual step in any bump PR.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

