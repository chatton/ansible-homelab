# setup_portainer

## Purpose

Installs/upgrades the Portainer CE server itself. Every other `portainer_*` role depends on this being up and reachable.

## Managed image(s)

- `portainer/portainer-ce` via `portainer_version` (currently `2.44.0`) - https://github.com/portainer/portainer/releases

## Known upgrade constraints

None documented yet.

## Other notes

This is core infra for the whole repo - an upgrade here affects every other service's management plane. Treat version bumps cautiously and check Portainer's own upgrade notes for breaking API changes the `chatton.portainer` collection might depend on.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-17: 2.20.3 → 2.44.0, PR TBD

