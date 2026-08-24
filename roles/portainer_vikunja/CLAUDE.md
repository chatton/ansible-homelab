# portainer_vikunja

## Purpose

Deploys Vikunja, a task/project management app, as separate API and frontend containers.

## Managed image(s)

- `vikunja/api` via `vikunja_api_tag` (currently `1.0.0`) - https://github.com/go-vikunja/vikunja/releases
- `vikunja/frontend` via `vikunja_frontend_tag` (currently `1.0.0`) - https://github.com/go-vikunja/vikunja/releases

## Known upgrade constraints

`vikunja_api_tag` and `vikunja_frontend_tag` must always be bumped together to the same version - never propose a PR that changes only one of them.

**Major version upgrades:** The 0.x → 1.0 → 2.x upgrade path involves breaking changes at each step. See upgrade history for details.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

**For v1.0.0 upgrade from 0.21.0:**
- Configuration changes required for CORS, OpenID, and SQLite paths
- API endpoint renames may affect integrations
- See https://vikunja.io/changelog/whats-new-in-vikunja-1.0.0/ for full migration guide

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-24: 0.21.0 → 1.0.0 (step 1 of 3 to reach v2.5.0) - PR TBD

