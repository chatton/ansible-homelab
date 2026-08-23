# portainer_vaultwarden

## Purpose

Deploys Vaultwarden, a self-hosted Bitwarden-compatible password manager. This holds sensitive credential data - treat upgrades more cautiously than a typical service.

## Managed image(s)

- `vaultwarden/server` via `vaultwarden_tag` (currently `1.37.2`) - https://github.com/dani-garcia/vaultwarden/releases

## Known upgrade constraints

None documented yet.

## Other notes

Recommend confirming a data backup exists before proposing/applying a version bump here, given what this service stores.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-23: 1.37.1 → 1.37.2, PR TBD

