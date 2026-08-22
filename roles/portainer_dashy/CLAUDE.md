# portainer_dashy

## Purpose

Deploys Dashy, the homelab's start-page/dashboard linking out to the other services.

## Managed image(s)

- `lissy93/dashy` via `dashy_tag` (currently `3.3.1`) - https://github.com/Lissy93/dashy/releases

## Known upgrade constraints

- v3.0.0 breaking: port changed from 80 to 8080, config location moved from /app/public to /app/user-data
- v4.0.0 breaking: requires Node 24+ (22.18.0+ also supported), drops 32-bit ARM support, strict YAML 1.2 parsing, config section names must be unique

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

- v3.x: Port mapping and volume mounts already updated in tasks/main.yml
- v4.x: Verify YAML config has unique section names, update to YAML 1.2 core syntax if needed

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-22: 2.1.1 → 3.3.1 (step 1 of multi-step upgrade to 4.6.0) - PR #100

