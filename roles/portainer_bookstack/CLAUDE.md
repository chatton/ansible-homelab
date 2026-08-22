# portainer_bookstack

## Purpose

Deploys BookStack, a self-hosted wiki/documentation platform.

## Managed image(s)

- `linuxserver/bookstack` via `bookstack_tag` (currently `24.12.1`) - https://docs.linuxserver.io/images/docker-bookstack/

## Known upgrade constraints

- Never skip major versions - upgrade sequentially (v23 → v24 → v25 → v26)
- v24.05 increased minimum PHP from 8.0.2 to 8.1
- v25.12 increased minimum PHP from 8.1 to 8.2

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

- Verify PHP 8.1+ is available in the container (required as of v24.05)
- Database backups before upgrade strongly recommended
- Migrations run automatically on container startup

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-22: 23.06.1 → 24.12.1 (step 1 of multi-step upgrade to 26.05.3) - PR #99

