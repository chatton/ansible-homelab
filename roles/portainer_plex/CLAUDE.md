# portainer_plex

## Purpose

Deploys Plex Media Server plus Tautulli (Plex stats/monitoring companion).

## Managed image(s)

- `lscr.io/linuxserver/plex` via `plex_tag` (currently `1.42.1`) - https://hub.docker.com/r/linuxserver/plex
- `lscr.io/linuxserver/tautulli` via `tautulli_tag` (currently `latest`)

## Known upgrade constraints

None documented yet.

## Other notes

`tautulli_tag` is currently `latest` (floating, unpinned) - a candidate for pinning.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

